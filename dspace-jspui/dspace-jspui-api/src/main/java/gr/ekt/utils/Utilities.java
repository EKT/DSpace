/**
 * The contents of this file are subject to the license and copyright
 * detailed in the LICENSE and NOTICE files at the root of the source
 * tree and available online at
 *
 * http://www.dspace.org/license/
 */
package gr.ekt.utils;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.TreeSet;

import org.dspace.authorize.AuthorizeException;
import org.dspace.browse.BrowseException;
import org.dspace.core.ConfigurationManager;
import org.dspace.core.Context;
import org.dspace.storage.rdbms.DatabaseManager;
import org.dspace.storage.rdbms.TableRow;

public class Utilities {

    public static Long calculateFreqOfItems(int browseIndicesId, String value) throws SQLException, AuthorizeException, BrowseException{
    	Long count;
    	
    	Context c = new Context();
        c.turnOffAuthorisationSystem();

        String findAll = "SELECT count(*) as count1 FROM bi_"+Integer.toString(browseIndicesId)+"_dmap,bi_"+Integer.toString(browseIndicesId)+"_dis WHERE bi_"+Integer.toString(browseIndicesId)+"_dmap.distinct_id=bi_"+Integer.toString(browseIndicesId)+"_dis.id AND bi_"+Integer.toString(browseIndicesId)+"_dis.value=?";
    	Object[] params = { value };
    	
    	//System.out.println("findAll is " + findAll);
    	TableRow row = DatabaseManager.querySingle(c, findAll, params);
    	count = new Long(row.getLongColumn("count1"));

    	c.complete();
    	return count;
    }
    
    public static int getBrowseIndicesId(String value)
		throws BrowseException
	{
	    int idx = 1;
	    String definition;
	    boolean found = false;
	    
	
	    while ( ((definition = ConfigurationManager.getProperty("webui.browse.index." + idx))) != null)
	    {
	        if    (definition.startsWith(value)){
	        	found = true;
	        	break;
	        }
	        idx++;
	    }
	    
	    if(!found)
	    	idx = 0;
	    
	    return idx;
	}
    
    public static boolean allowFreqOfItems(int browseIndicesId){
    	boolean allow = true;
    	String allowStr;
    	
    	if ( ((allowStr = ConfigurationManager.getProperty("webui.browse.metadata.show-freq." + browseIndicesId))) != null)
    		allow = Boolean.parseBoolean(allowStr);
    	
    	//System.out.println("returning " + allow);
    	return allow;
    }
    
    public static String showFreqOfItems(String browseCatName, String browseItemName) throws SQLException, AuthorizeException, BrowseException {
    	
    	//System.out.println("got request for cat " + browseCatName + " and item " + browseItemName);
    	
    	Long frequencies;
    	String freqStr = "";
    	int browseIndicesId = Utilities.getBrowseIndicesId(browseCatName);

    	if (browseIndicesId > 0 && Utilities.allowFreqOfItems(browseIndicesId)) {    		
    		frequencies = Utilities.calculateFreqOfItems(browseIndicesId, browseItemName);
    		freqStr = "(" + frequencies.toString() + ")";
    	}
    	
    	return freqStr;
    }
    
    public static int getFreqOfItems(String browseCatName, String browseItemName) throws SQLException, AuthorizeException, BrowseException{
    	
    	Long frequencies = new Long(0);
    	
    	String freqStr = "";
    	int browseIndicesId = Utilities.getBrowseIndicesId(browseCatName);
    	if(browseIndicesId > 0 && Utilities.allowFreqOfItems(browseIndicesId)){    		
    		frequencies = Utilities.calculateFreqOfItems(browseIndicesId,browseItemName);
    		
    	}
    	
    	return frequencies.intValue();
    }
}
