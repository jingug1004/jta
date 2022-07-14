package anyfive.framework.grid.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class GridConfigDao extends NAbstractServletDao
{
    public GridConfigDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그리드 환경설정 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGridConfig(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/retrieveGridConfig");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 그리드 환경설정 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createGridConfig(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/createGridConfig");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그리드 환경설정 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateGridConfig(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/updateGridConfig");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그리드 컬럼 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveGridColumnList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/retrieveGridColumnList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 그리드 컬럼 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteGridColumnList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/deleteGridColumnList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그리드 컬럼 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createGridColumnList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/createGridColumnList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_columnList"));
    }

    /**
     * 그리드 정렬 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveGridSortingList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/retrieveGridSortingList");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 그리드 정렬 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteGridSortingList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/deleteGridSortingList");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 그리드 정렬 목록 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createGridSortingList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/gridconfig", "/createGridSortingList");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiData("ds_sortingList"));
    }
}
