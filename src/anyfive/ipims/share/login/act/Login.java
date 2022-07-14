package anyfive.ipims.share.login.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.config.NConfig;
import any.core.exception.NBizException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.session.SessionUtil;
import anyfive.framework.session.UserInfo;
import anyfive.ipims.share.login.biz.LoginBiz;

/**
 * 로그인
 */
public class Login implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);
        String sysId = xReq.getParam("SYS_ID");

        if (xReq.getParam("LOGIN_ID").equals("")) {
            throw new NBizException(1, nsr.message.get("msg.login.error.001"));
        }

        if (xReq.getParam("LOGIN_PW").equals("")) {
            throw new NBizException(2, nsr.message.get("msg.login.error.002"));
        }

        String SysType = NConfig.getString("/config/login-system");

        if(SysType.equals("PATENT")){
            nsr.openConnection();
      /*      if(NConfig.getBoolean("/config/hr/enable") == true ){
                nsr.openConnection("hr");
            }*/
            UserInfo userInfo = null;
            LoginBiz biz = new LoginBiz(nsr);

            if (sysId.equals("SYSADMIN") != true){
                userInfo = biz.retrieveCombineLogin(xReq);
            }else{
                userInfo = biz.retrieveLogin(xReq);
            }

     /*       if(NConfig.getBoolean("/config/hr/enable") == true ){
                nsr.closeConnection("hr");
            }*/
            nsr.closeConnection();

            SessionUtil.setUserInfo(req, userInfo);
        }
        else{
            nsr.openConnection();
            LoginBiz biz = new LoginBiz(nsr);
            UserInfo userInfo = biz.retrieveLogin(xReq);
            nsr.closeConnection();
            SessionUtil.setUserInfo(req, userInfo);
        }

    }
}
