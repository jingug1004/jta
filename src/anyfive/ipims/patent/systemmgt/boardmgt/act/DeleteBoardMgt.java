package anyfive.ipims.patent.systemmgt.boardmgt.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.boardmgt.biz.BoardMgtBiz;

/**
 * 게시판 관리 삭제
 */
public class DeleteBoardMgt implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        nsr.openConnection(true);
        BoardMgtBiz biz = new BoardMgtBiz(nsr);
        biz.deleteBoardMgt(xReq);
        nsr.closeConnection();
    }
}
