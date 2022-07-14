package e3ps.sap;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.IRepository;
import com.sap.mw.jco.JCO;

public class SAPInterface {

    /**
     * @param args
     */

        private IRepository repository;
        private JCO.Client client;

        public SAPInterface() {
            try {
                client = SAPRFCConnect.getConnection();
                client.connect();
                repository = JCO.createRepository("BFREPOSITORY",client);
            }
            catch (JCO.Exception ex) {
                ex.printStackTrace();
            }//try
        }

        public boolean SAPInfoEHRInterface(String startDate, String endDate) {


            boolean flag = false;
            if (repository == null) {
                repository = JCO.createRepository("BFREPOSITORY",client);
            }

            try {

                IFunctionTemplate tmpl = repository.getFunctionTemplate("Z19PSF_00000024");

                if (tmpl == null) {
                    System.out.println("Could not find function Z19PSF_00000024");
                    return false;
                }

                // if the function definition was found in backend system
                    if(tmpl != null) {

                        // Create a function from the template
                        JCO.Function function = tmpl.getFunction();

                        // Fill in input parameters
                        JCO.ParameterList input = function.getImportParameterList();

                        input.setValue(startDate, "I_BEGINDAY");
                        input.setValue(endDate, "I_ENDDAY");

                        // Call the remote system
                        client.execute(function);

                       //E_CNT             근태 Interface 처리 건수
                     //E_RESULT          I/F 결과 (‘성공’은 공백, ‘실패’는 ‘E’)
                     //E_MSG             실패 시 에러메시지


                      String e_result = function.getExportParameterList().getString("E_RESULT");
                      String e_msg = function.getExportParameterList().getString("E_MSG");

                        System.out.println("Result Message : " + e_msg);

                        if(" ".equals(e_result)) {
                            flag = true;
                        }
                        else {
                            System.out.println("Error Message_a : " + function.getExportParameterList().getString("E_MSG"));

                        }
                    }
                    else {
                        System.out.println("Function Z19PSF_00000010 not found in backend system.");
                    }
            }
            catch (Exception ex) {
                ex.printStackTrace();
            }
            return flag;
        }


    public static void main(String[] args) {
        // TODO Auto-generated method stub
        SAPInterface e = new SAPInterface();
          boolean flag = e.SAPInfoEHRInterface("20080911", "20081011");
          System.out.println(">>>>>>>> : " + flag);
    }

}
