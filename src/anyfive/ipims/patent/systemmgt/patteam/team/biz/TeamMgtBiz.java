package anyfive.ipims.patent.systemmgt.patteam.team.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.team.dao.TeamMgtDao;

public class TeamMgtBiz extends NAbstractServletBiz
{
    public TeamMgtBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 팀정보 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePatTeamTeamList(AjaxRequest xReq) throws NException
    {
        TeamMgtDao dao = new TeamMgtDao(this.nsr);

        return dao.retrievePatTeamTeamList(xReq);
    }

    /**
     * 사용구분 변경
     *
     * @param xReq
     * @throws NException
     */
    public void updatePatTeamTeamList(AjaxRequest xReq) throws NException
    {
        NMultiData data = xReq.getMultiData("ds_patTeamTeamList");
        TeamMgtDao dao = new TeamMgtDao(this.nsr);

        String useYN = xReq.getParam("USE_YN");
        String code = null;

        for (int i = 0; i < data.getRowSize(); i++) {
            code = data.getString(i, "DEPT_CODE");

        dao.updatePatTeamTeamList(code, useYN);
      }
    }
}
