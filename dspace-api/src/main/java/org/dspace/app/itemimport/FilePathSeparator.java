package org.dspace.app.itemimport;

import java.util.ArrayList;
import java.util.List;

import gr.ekt.transformationengine.core.Modifier;
import gr.ekt.transformationengine.core.Record;
import gr.ekt.transformationengine.exceptions.UnimplementedAbstractMethod;

public class FilePathSeparator extends Modifier {

	public FilePathSeparator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void modify(Record record) throws UnimplementedAbstractMethod {
		
		ArrayList<Object> newValues = new ArrayList<Object>();
		
		List<Object> concatenatedPathList = record.getByName("Path");
		for (Object pathObject : concatenatedPathList){
			String concatenatedPath = (String)pathObject;
			String[] paths = concatenatedPath.split(";");
			for (String path : paths){
				newValues.add(path.trim());
			}
		}
		
		record.removeField("Path");
		record.addField("Path", newValues);
	}

}
