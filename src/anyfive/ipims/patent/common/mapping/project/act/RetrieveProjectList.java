package anyfive.ipims.patent.common.mapping.project.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.dataset.NMultiData;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.ajax.AjaxResponse;
import anyfive.ipims.patent.common.mapping.consts.MappingDiv;
import anyfive.ipims.patent.common.mapping.project.biz.ProjectMappBiz;

/**
 * 프로젝트 목록 조회
 */
public class RetrieveProjectList implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection();
        ProjectMappBiz biz = new ProjectMappBiz(nsr);
        NMultiData result = biz.retrieveProjectList(xReq.getParam("REF_ID"), MappingDiv.NONE);
        nsr.closeConnection();

        AjaxResponse xRes = new AjaxResponse(res);
        xRes.flush(result, xReq.getParam("_DS_ID_"));
    }
}
