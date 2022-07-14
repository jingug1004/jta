package epro.jco.common;

import java.util.ArrayList;

import com.sap.mw.jco.IFunctionTemplate;
import com.sap.mw.jco.IRepository;
import com.sap.mw.jco.JCO;

import any.core.log.NLog;

public class SAPInterface
{

    /**
     * @param args
     */

    private IRepository repository;

    private JCO.Client  client;
    private String      clientName;
    private String      userName;
    private String      passWd;
    private String      lang;
    private String      ashost;
    private String      sysnr;

    public SAPInterface()
    {

    }

    public void setClient(String JCOClient)
    {

        clientName = JCOClient;
    }

    public String getClient()
    {
        return clientName;
    }

    public void setUser(String userId)
    {

        userName = userId;
    }

    public String getUser()
    {
        return userName;
    }

    public void setPwd(String pwd)
    {

        passWd = pwd;
    }

    public String getPwd()
    {
        return passWd;
    }

    public void setLang(String JCOlang)
    {

        lang = JCOlang;
    }

    public String getLang()
    {
        return lang;
    }

    public void setHost(String host)
    {

        ashost = host;
    }

    public String getHost()
    {
        return ashost;
    }

    public void setSysNo(String JCOsysNo)
    {

        sysnr = JCOsysNo;
    }

    public String getSysNo()
    {
        return sysnr;
    }

    public String SAPInfoIPSInterface(String RFCNAME, String startDate, String endDate, String empNo, String currentUnity, String exchage, ArrayList<String> aCostInfo, String slipKind)
    {

        String retValue = null;
        client = RFCConnect.getConnection(getClient(), getUser(), getPwd(), getLang(), getHost(), getSysNo());
        client.connect();
        // JCO.Attributes attributes = client.getAttributes();
        // System.out.println("connection attributes:\n"+"--------------------\n"+attributes);
        repository = JCO.createRepository("BFREPOSITORY", client);

        if (repository == null) {
            repository = JCO.createRepository("BFREPOSITORY", client);
        }

        try {

            IFunctionTemplate tmpl = repository.getFunctionTemplate(RFCNAME);

            if (tmpl == null) {
                System.out.println("Could not find function " + RFCNAME);
                return retValue;
            }

            // Create a function from the template
            JCO.Function function = tmpl.getFunction();
            System.out.println("Function :: "+ function.toString());
            // Fill in input parameters
            JCO.ParameterList input = function.getImportParameterList();

            input.setValue(startDate, "I_BUDAT");
            input.setValue(endDate, "I_BLDAT");
            input.setValue(empNo, "I_PERNR");
            input.setValue(currentUnity, "I_WAERS");
            input.setValue(exchage, "I_KURSF");
            System.out.println("I_BUDAT : " + startDate);
            System.out.println("I_BLDAT : " + endDate);
            System.out.println("I_PERNR : " + empNo);
            System.out.println("I_WAERS : " + currentUnity);
            System.out.println("I_KURSF : " + exchage);

            // Fill in input parameters

            JCO.Table inputDataTable = null;
            inputDataTable = function.getTableParameterList().getTable("T_SENDER");
            if (inputDataTable == null) {
                System.out.println("JCO.Table 'T_SENDER' not exist");
                return retValue;
            }

            String gubun = null;
            String sapCode = null;
            String wonPrice = null;
            String deptCode = null;
            String appNo = null;
            String txt = null;
            String price = null;
            String tax = null;
            String account_slip_no = null;

            // 선급금
            if (slipKind.equals("C")) {
                for (int i = 0; i < aCostInfo.size(); i = i + 7) {
                    gubun = aCostInfo.get(i + 0);
                    sapCode = aCostInfo.get(i + 1);
                    wonPrice = aCostInfo.get(i + 2);
                    appNo = aCostInfo.get(i + 3);
                    txt = aCostInfo.get(i + 4);
                    price = aCostInfo.get(i + 5);
                    tax = aCostInfo.get(i + 6);
                    System.out.println("aCostInfo.GUBUN : " + gubun);
                    System.out.println("aCostInfo.SAP_CODE : " + sapCode);
                    System.out.println("aCostInfo.WON_PRICE : " + wonPrice);
                    System.out.println("aCostInfo.APP_NO : " + appNo);
                    System.out.println("aCostInfo.TXT : " + txt);
                    System.out.println("aCostInfo.PRICE : " + price);
                    System.out.println("aCostInfo.TAX : " + tax);
                    inputDataTable.appendRow();
                    inputDataTable.setValue(gubun, "ZGUBUN");// 구분
                    inputDataTable.setValue(sapCode, "LIFNR");// 구매처
                    inputDataTable.setValue(wonPrice, "WRBTR1");// 금액
                    inputDataTable.setValue(appNo, "ZUONR");// 지정번호
                    inputDataTable.setValue(txt, "SGTXT");// 텍스트
                    inputDataTable.setValue(price, "WRBTR2");// 공급가액
                    inputDataTable.setValue(tax, "MWSKZ");// 세금코드
                }
            }
            // 연차료
            if (slipKind.equals("A") || slipKind.equals("T")) {
                for (int i = 0; i < aCostInfo.size(); i = i + 8) {

                    // ---------------------------------구분 ---------------------------//

                    gubun = aCostInfo.get(i + 0);
                    sapCode = aCostInfo.get(i + 1);
                    wonPrice = aCostInfo.get(i + 2);
                    deptCode = aCostInfo.get(i + 3);
                    appNo = aCostInfo.get(i + 4);
                    txt = aCostInfo.get(i + 5);
                    price = aCostInfo.get(i + 6);
                    tax = aCostInfo.get(i + 7);
                    System.out.println("aCostInfo.GUBUN : " + gubun);
                    System.out.println("aCostInfo.SAP_CODE : " + sapCode);
                    System.out.println("aCostInfo.WON_PRICE : " + wonPrice);
                    System.out.println("aCostInfo.DEPT_CODE : " + deptCode);
                    System.out.println("aCostInfo.APP_NO : " + appNo);
                    System.out.println("aCostInfo.TXT : " + txt);
                    System.out.println("aCostInfo.PRICE : " + price);
                    System.out.println("aCostInfo.TAX : " + tax);

                    inputDataTable.appendRow();
                    inputDataTable.setValue(gubun, "ZGUBUN");// 구분
                    inputDataTable.setValue(sapCode, "LIFNR");// 구매처
                    inputDataTable.setValue(wonPrice, "WRBTR1");// 금액
                    inputDataTable.setValue(deptCode, "KOSTL");// 부서
                    inputDataTable.setValue(appNo, "ZUONR");// 지정번호
                    inputDataTable.setValue(txt, "SGTXT");// 텍스트
                    inputDataTable.setValue(price, "WRBTR2");// 공급가액
                    inputDataTable.setValue(tax, "MWSKZ");// 세금코드

                }
            }

            // 자산/자본적지출
            if (slipKind.equals("S") || slipKind.equals("I")) {

                appNo = aCostInfo.get(0);
                wonPrice = aCostInfo.get(1);
                account_slip_no = aCostInfo.get(2);
                System.out.println("aCostInfo.APP_NO : " + appNo);
                System.out.println("aCostInfo.ACCOUNT_SLIP_NO : " + account_slip_no);
                System.out.println("aCostInfo.WON_PRICE : " + wonPrice);

                inputDataTable.appendRow();
                inputDataTable.setValue(appNo, "NUM");// 출원번호
                inputDataTable.setValue(wonPrice, "DMBTR");// 금액
                inputDataTable.setValue(account_slip_no, "ANLN1");// 자산번호
            }
            // 출원포기
            if (slipKind.equals("R")) {
                appNo = aCostInfo.get(0);
                wonPrice = aCostInfo.get(1);
                deptCode = aCostInfo.get(2);
                System.out.println("aCostInfo.APP_NO : " + appNo);
                System.out.println("aCostInfo.DEPT_CODE : " + deptCode);
                System.out.println("aCostInfo.WON_PRICE : " + wonPrice);

                inputDataTable.appendRow();
                inputDataTable.setValue(appNo, "NUM");// 출원번호
                inputDataTable.setValue(wonPrice, "DMBTR");// 금액
                inputDataTable.setValue(deptCode, "KOSTL");// 부서
            }
            // Call the remote system
            client.execute(function);

            // E_CNT 근태 Interface 처리 건수
            // E_RESULT I/F 결과 (‘성공’은 공백, ‘실패’는 ‘E’)
            // E_MSG 실패 시 에러메시지

            String e_result = function.getExportParameterList().getString("E_RESULT");
            String e_msg = function.getExportParameterList().getString("E_MSG");
            String e_belnr = function.getExportParameterList().getString("E_BELNR");
            String e_gjahr = function.getExportParameterList().getString("E_GJAHR");

            System.out.println("Result : " + e_result);
            System.out.println("Result Message : " + e_msg);
            System.out.println("Result E_BELNR : " + e_belnr);
            System.out.println("Result E_GJAHR : " + e_gjahr);

            if ("S".equals(e_result)) {
                retValue = e_belnr + "," + e_gjahr + "," + e_msg;
            } else {
                System.out.println("Error Message : " + function.getExportParameterList().getString("E_MSG"));
                String error = "error";
                retValue = error + "," + e_msg;
            }

        } catch (JCO.Exception e) {
            NLog.error.writeln(e.getMessage());
            e.printStackTrace();
        } finally {
            client.disconnect();
            repository = null;
        }
        return retValue;
    }

    // 전표취소
    public String SAPInfoIPSInterfaceCancel(String RFCNAME, String slipNo, String slipYear)
    {

        String retValue = null;
        client = RFCConnect.getConnection(getClient(), getUser(), getPwd(), getLang(), getHost(), getSysNo());
        client.connect();
        // JCO.Attributes attributes = client.getAttributes();
        // System.out.println("connection attributes:\n"+"--------------------\n"+attributes);
        repository = JCO.createRepository("BFREPOSITORY", client);

        if (repository == null) {
            repository = JCO.createRepository("BFREPOSITORY", client);
        }

        try {

            IFunctionTemplate tmpl = repository.getFunctionTemplate(RFCNAME);

            if (tmpl == null) {
                System.out.println("Could not find function " + RFCNAME);
                return retValue;
            }

            // Create a function from the template
            JCO.Function function = tmpl.getFunction();

            // Fill in input parameters
            JCO.ParameterList input = function.getImportParameterList();

            input.setValue(slipNo, "I_BELNR");
            input.setValue(slipYear, "I_GJAHR");

            // Call the remote system
            client.execute(function);

            // E_CNT 근태 Interface 처리 건수
            // E_RESULT I/F 결과 (‘성공’은 공백, ‘실패’는 ‘E’)
            // E_MSG 실패 시 에러메시지

            String e_result = function.getExportParameterList().getString("E_RESULT");
            String e_msg = function.getExportParameterList().getString("E_MSG");

            System.out.println("Result Message : " + e_msg);

            if ("S".equals(e_result)) {
                retValue = e_result;
            } else {
                System.out.println("Error Message : " + function.getExportParameterList().getString("E_MSG"));
                String error = "error";
                retValue = error + "," + e_msg;
            }

        } catch (JCO.Exception e) {
            NLog.error.writeln(e.getMessage());
            e.printStackTrace();
        } finally {
            client.disconnect();
            repository = null;
        }
        return retValue;
    }

    // 자산번호 생성
    public String SAPInfoIPSInterfaceAssetNo(String RFCNAME, String startDate, String detpCode, String assetTxt1, String assetTxt2, String rightDiv)
    {

        String retValue = null;
        client = RFCConnect.getConnection(getClient(), getUser(), getPwd(), getLang(), getHost(), getSysNo());
        client.connect();
        // JCO.Attributes attributes = client.getAttributes();
        // System.out.println("connection attributes:\n"+"--------------------\n"+attributes);
        repository = JCO.createRepository("BFREPOSITORY", client);

        if (repository == null) {
            repository = JCO.createRepository("BFREPOSITORY", client);
        }

        try {

            IFunctionTemplate tmpl = repository.getFunctionTemplate(RFCNAME);

            if (tmpl == null) {
                System.out.println("Could not find function " + RFCNAME);
                return retValue;
            }

            // Create a function from the template
            JCO.Function function = tmpl.getFunction();

            // Fill in input parameters
            JCO.ParameterList input = function.getImportParameterList();

            input.setValue(startDate, "I_AFABG");
            input.setValue(detpCode, "I_KOSTL");
            input.setValue("특허자산7==" + assetTxt1, "I_TXT01"); // 출원번호
            input.setValue("특허자산8==" + assetTxt2, "I_TXT02"); // 등록번호
            input.setValue(rightDiv, "I_CLASS");

            // Call the remote system
            client.execute(function);

            // E_CNT 근태 Interface 처리 건수
            // E_RESULT I/F 결과 (‘성공’은 공백, ‘실패’는 ‘E’)
            // E_MSG 실패 시 에러메시지

            String e_result = function.getExportParameterList().getString("E_RESULT");
            String e_msg = function.getExportParameterList().getString("E_MSG");
            String e_anln1 = function.getExportParameterList().getString("E_ANLN1");

            System.out.println("Result Message : " + e_msg);
            System.out.println("Result E_RESULT : " + e_result);

            if ("S".equals(e_result)) {
                if (e_msg.equals("이미 생성된 자산 마스터 입니다.")) {
                    String error = "error";
                    retValue = error + "," + e_msg;
                }
                retValue = e_anln1;
            } else {
                System.out.println("Error Message : " + function.getExportParameterList().getString("E_MSG"));

            }

        } catch (JCO.Exception e) {
            NLog.error.writeln(e.getMessage());
            e.printStackTrace();
        } finally {
            client.disconnect();
            repository = null;
        }
        return retValue;
    }
}
