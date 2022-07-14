package anyfive.ipims.share.login.biz;

import JSADUSER.JSADUserinfo.Service1SoapProxy;
import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.UserInfo;
import anyfive.ipims.share.login.dao.LoginDao;
import anyfive.ipims.share.login.dao.LoginHrDao;

public class LoginBiz extends NAbstractServletBiz
{
    public LoginBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 로그인 사용자정보 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveLoginUserSearchList(AjaxRequest xReq) throws NException
    {
        LoginDao dao = new LoginDao(this.nsr);

        return dao.retrieveLoginUserSearchList(xReq);
    }

    /**
     * 로그인 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public UserInfo retrieveLogin(AjaxRequest xReq ) throws NException
    {
        return this.retrieveLogin(xReq.getParam("LOGIN_ID"), xReq.getParam("LOGIN_PW"), "" );
    }

    /**
     * 로그인 정보 조회
     *
     * @param loginId
     * @param loginPw
     * @return
     * @throws NException
     */
    public UserInfo retrieveLogin(String loginId, String loginPw, String loginAd) throws NException
    {

        LoginDao dao = new LoginDao(this.nsr);

        NSingleData userData = dao.retrieveLogin(loginId);
        String userId = userData.getString("USER_ID"); // 마스터 아이디
        String htCode = userData.getString("HT_CODE"); // 휴직코드
        String SysType = NConfig.getString("/config/login-system");


        if(SysType.equals("PATENT")){
            LoginHrDao daoHr = new LoginHrDao(this.nsr);
            dao = new LoginDao(this.nsr);
            //임시 테이블 정보 삭제
            daoHr.deleteUserInfo();

            NMultiData EhruserData =  daoHr.retrieveUsrInfo(loginId);
            userData = dao.retrieveLogin(loginId);

            userId = userData.getString("USER_ID"); // 마스터 아이디
            htCode = userData.getString("HT_CODE"); // 휴직코드
            String EhrUserId = null;
            String EhrUserPass = null;
            int usrCnt = EhruserData.getRowSize();
            for (int i=0; i<usrCnt; i++){
            EhrUserId = EhruserData.getString(i, "EMP_ID"); //EHR 아이디
            EhrUserPass = EhruserData.getString(i, "PWD"); // EHR 패스워드
            }

            System.out.println("loginAd :  " + loginAd)
            ;
             if (!loginAd.equals("ADOK") == true || loginAd.equals("")){
               if (loginId.equals(EhrUserId)){
                    if (userData.isEmpty()) {
                        throw new NBizException(3, this.nsr.message.get("msg.login.error.003"));
                    }

                    if (loginPw != null && EhrUserPass.equals(loginPw) != true) {
                        throw new NBizException(4, this.nsr.message.get("msg.login.error.004"));
                    }

                    if (htCode.equals("C") || htCode.equals("P")) {
                    } else if (htCode.equals("T")) {
                        throw new NBizException(3, "귀하는 현재 퇴직상태입니다.");
                    } else if (htCode.equals("H")) {
                        throw new NBizException(3, "귀하는 현재 휴직상태입니다.");
                    } else {
                        throw new NBizException(3, "귀하의 재직상태를 확인하여주시기 바랍니다.");
                    }
                }
             }
        } else {

            dao = new LoginDao(this.nsr);

            userData = dao.retrieveLogin(loginId);

            userId = userData.getString("USER_ID"); // 마스터 아이디
            htCode = userData.getString("HT_CODE"); // 휴직코드

            if (userData.isEmpty()) {
                throw new NBizException(3, this.nsr.message.get("msg.login.error.003"));
            }

            if (loginPw != null && userData.getString("LOGIN_PW").equals(loginPw) != true) {
                throw new NBizException(4, this.nsr.message.get("msg.login.error.004"));
            }

            if (htCode.equals("C") || htCode.equals("P")) {
            } else if (htCode.equals("T")) {
                throw new NBizException(3, "귀하는 현재 퇴직상태입니다.");
            } else if (htCode.equals("H")) {
                throw new NBizException(3, "귀하는 현재 휴직상태입니다.");
            } else {
                throw new NBizException(3, "귀하의 재직상태를 확인하여주시기 바랍니다.");
            }
        }

        dao.updateLastLoginDatetime(userId);

        UserInfo userInfo = new UserInfo();

        userInfo.setLogin(true);
        userInfo.setUserId(userId);
        userInfo.setLoginId(loginId);
        userInfo.setSystemType(userData.getString("SYSTEM_TYPE"));
        userInfo.setEmpNo(userData.getString("EMP_NO"));
        userInfo.setEmpHname(userData.getString("EMP_HNAME"));
        userInfo.setEmpEname(userData.getString("EMP_ENAME"));
        userInfo.setEmpCname(userData.getString("EMP_CNAME"));
        userInfo.setMailAddr(userData.getString("MAIL_ADDR"));
        userInfo.setDivisnCode(userData.getString("DIVISN_CODE"));
        userInfo.setDivisnName(userData.getString("DIVISN_NAME"));
        userInfo.setDeptCode(userData.getString("DEPT_CODE"));
        userInfo.setDeptName(userData.getString("DEPT_NAME"));
        userInfo.setOfficeCode(userData.getString("OFFICE_CODE"));
        userInfo.setOfficeName(userData.getString("OFFICE_NAME"));
        userInfo.setMenuGroupList(dao.retrieveLoginUserMenuGroupList(userId));

        return userInfo;
    }

    /**
     * 통합인증 조회
     *
     * @param xReq
     * @return
     * @throws Exception
     */
    public UserInfo retrieveCombineLogin(AjaxRequest xReq) throws Exception
    {
        String loginId = xReq.getParam("LOGIN_ID");
        String loginPw = xReq.getParam("LOGIN_PW");
        String ADOK = "";

        Service1SoapProxy SSP = new Service1SoapProxy();

            ADOK = SSP.ADUserCHK(loginId, loginPw);

            if(!ADOK.equals("ADOK")){
                throw new NBizException(3, "인증에 실패 하였습니다. ");
            }

        return this.retrieveLogin(loginId, loginPw, ADOK);
    }
}
