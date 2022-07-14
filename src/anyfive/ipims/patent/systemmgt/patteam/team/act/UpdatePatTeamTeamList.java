package anyfive.ipims.patent.systemmgt.patteam.team.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.patteam.team.biz.TeamMgtBiz;

/**
 * 건담당자 일괄변경 저장
 */
public class UpdatePatTeamTeamList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        TeamMgtBiz biz = new TeamMgtBiz(nsr);
        biz.updatePatTeamTeamList(xReq);
        nsr.closeConnection();
    }
}
