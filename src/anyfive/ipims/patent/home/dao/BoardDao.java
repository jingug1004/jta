package anyfive.ipims.patent.home.dao;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class BoardDao extends NAbstractServletDao
{
    public BoardDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/home/board", "/retrieveBoardList");
        dao.bind(xReq);

        return dao.executeQuery();
    }
}
