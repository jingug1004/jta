package e3ps.sap;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import com.sap.mw.jco.JCO;

public class SAPRFCConnect {

    /**
     * @param args
     */

    protected static String properties_filename = "d:/AnyBuilder/workspace/IPIMS_Java/JuSung/src/e3ps/sap";
  protected static Properties login_properties = null;

    public static JCO.Client getConnection()
    {
        JCO.Client client = null;
        try {
            client = JCO.createClient(getLoginProperties());

            if(client == null)
            {
                System.out.println("######## JCO.Client is Null");
                System.out.println("JCO.Client Failed");
            }
            else
            {
                System.out.println("######## JCO.Client is not Null");
                System.out.println("JCO.Client OK");
            }

        }
        catch (JCO.Exception ex) {
            ex.printStackTrace();
        }
        catch(Exception ex) {
            ex.printStackTrace();
        }
        return client;
    }
    public static Properties getLoginProperties()
    {
        if (login_properties == null) {
            login_properties = new Properties();
            try {
                login_properties.load(new FileInputStream(properties_filename));
            }
            catch (IOException ex) {
                System.out.println(ex);
                System.exit(1);
            }//try
        }
        return login_properties;
    }

    public static void main(String[] args) {
        // TODO Auto-generated method stub

    }

}
