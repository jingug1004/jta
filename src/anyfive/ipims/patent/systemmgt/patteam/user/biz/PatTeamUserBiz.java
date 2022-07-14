package anyfive.ipims.patent.systemmgt.patteam.user.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.user.dao.PatTeamUserDao;

public class PatTeamUserBiz extends NAbstractServletBiz
{
    public PatTeamUserBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 특허팀 사용자 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamUserList(AjaxRequest xReq) throws NException
    {
        PatTeamUserDao dao = new PatTeamUserDao(this.nsr);

        return dao.retrievePatTeamUserList(xReq);
    }

    /**
     * 특허팀 사용자 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamUser(AjaxRequest xReq) throws NException
    {
        PatTeamUserDao dao = new PatTeamUserDao(this.nsr);

        return dao.retrievePatTeamUser(xReq);
    }

    /**
     * 특허팀 사용자 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePatTeamUser(AjaxRequest xReq) throws NException
    {
        PatTeamUserDao dao = new PatTeamUserDao(this.nsr);
        if( dao.updatePatTeamUser(xReq) == 0) {
            throw new NBizException("Login ID가 존재합니다.");
        }
    }
}
