package anyfive.ipims.patent.applymgt.priorsearch.result.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class PriorSearchResultDao extends NAbstractServletDao
{
    public PriorSearchResultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행기술조사 결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/result", "/retrievePriorSearchResult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 선행기술조사 결과 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createPriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/result", "/createPriorSearchResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 선행기술조사 결과 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchResult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/result", "/updatePriorSearchResult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 선행기술조사 결과 완료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updatePriorSearchComplete(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/result", "/updatePriorSearchComplete");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 조사결과 통보메일 발송정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchInformMailInfo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/priorsearch/result", "/retrievePriorSearchInformMailInfo");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }
}
