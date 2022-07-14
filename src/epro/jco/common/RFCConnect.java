package epro.jco.common;

import com.sap.mw.jco.JCO;

public class RFCConnect {


    public static JCO.Client getConnection(String client,String user,String passwd,String lang,String ashost,String sysnr)
    {
        JCO.Client client1 = null;
        try {
            client1 = JCO.createClient(client, user, passwd, lang, ashost, sysnr);

            if(client1 == null)
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
        return client1;
    }

}
