package anyfive.ipims.patent.home.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.home.dao.BoardDao;

public class BoardBiz extends NAbstractServletBiz
{
    public BoardBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 게시판 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveBoardList(AjaxRequest xReq) throws NException
    {
        BoardDao dao = new BoardDao(this.nsr);

        return dao.retrieveBoardList(xReq);
    }
}
