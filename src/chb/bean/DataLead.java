package chb.bean;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataLead {

    private List<String> row = new ArrayList<String>();

    public String get(int column) {
        return row.get(column);
    }

    public void add( String value) {
        this.row.add(value);
    }

    public int size() {
        return  this.row.size();
    }
}
