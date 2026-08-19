// Exports Ghidra-derived listing, function metadata, and decompiler C for one program.
// Output is explicitly tool-derived and is paired with the caller's input hash/configuration.
import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.CodeUnit;
import ghidra.program.model.listing.CodeUnitIterator;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;

import java.io.File;
import java.io.PrintWriter;

public class ExportDAADAnalysis extends GhidraScript {
    private static String clean(String value) {
        return value == null ? "" : value.replace("\t", " ").replace("\r", " ").replace("\n", " ");
    }

    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length != 1) {
            throw new IllegalArgumentException("Expected one output-directory argument");
        }
        File output = new File(args[0]);
        if (!output.isDirectory() && !output.mkdirs()) {
            throw new IllegalStateException("Cannot create output directory: " + output);
        }

        try (PrintWriter listing = new PrintWriter(new File(output, "ghidra-listing.txt"));
             PrintWriter functions = new PrintWriter(new File(output, "ghidra-functions.tsv"));
             PrintWriter decompiled = new PrintWriter(new File(output, "ghidra-decompilation.c"));
             PrintWriter metadata = new PrintWriter(new File(output, "ghidra-metadata.json"))) {
            metadata.println("{");
            metadata.println("  \"producer\": \"Ghidra ExportDAADAnalysis\",");
            metadata.println("  \"program\": \"" + clean(currentProgram.getName()) + "\",");
            metadata.println("  \"min_address\": \"" + currentProgram.getMinAddress() + "\",");
            metadata.println("  \"max_address\": \"" + currentProgram.getMaxAddress() + "\"");
            metadata.println("}");

            CodeUnitIterator units = currentProgram.getListing().getCodeUnits(true);
            while (units.hasNext() && !monitor.isCancelled()) {
                CodeUnit unit = units.next();
                listing.println(unit.getAddress() + "\t" + unit.toString());
            }

            functions.println("entry\tname\tbody\tcomment\tdecompilation_status");
            DecompInterface decompiler = new DecompInterface();
            decompiler.openProgram(currentProgram);
            FunctionIterator iterator = currentProgram.getFunctionManager().getFunctions(true);
            while (iterator.hasNext() && !monitor.isCancelled()) {
                Function function = iterator.next();
                Address entry = function.getEntryPoint();
                DecompileResults result = decompiler.decompileFunction(function, 60, monitor);
                boolean completed = result != null && result.decompileCompleted() && result.getDecompiledFunction() != null;
                functions.println(entry + "\t" + clean(function.getName()) + "\t" + clean(function.getBody().toString()) + "\t" + clean(function.getComment()) + "\t" + (completed ? "completed" : "incomplete"));
                decompiled.println("/* Ghidra-derived function " + entry + " " + function.getName() + " */");
                if (completed) {
                    decompiled.println(result.getDecompiledFunction().getC());
                } else {
                    decompiled.println("/* Decompilation incomplete: " + clean(result == null ? "no result" : result.getErrorMessage()) + " */");
                }
                decompiled.println();
            }
            decompiler.dispose();
        }
    }
}
