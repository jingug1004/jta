package anyfive.framework.grid.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.grid.dao.GridConfigDao;

public class GridConfigBiz extends NAbstractServletBiz
{
    public GridConfigBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 그리드 컬럼 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGridColumnList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_configInfo_" + xReq.getParam("GRID_ID"), dao.retrieveGridConfig(xReq));
        result.set("ds_columnList_" + xReq.getParam("GRID_ID"), dao.retrieveGridColumnList(xReq));

        return result;
    }

    /**
     * 그리드 컬럼 목록 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateGridColumnList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        xReq.setUserData("COLUMN_YN", "1");

        if (dao.updateGridConfig(xReq) == 0) {
            dao.createGridConfig(xReq);
        }

        dao.deleteGridColumnList(xReq);
        dao.createGridColumnList(xReq);
    }

    /**
     * 그리드 컬럼 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteGridColumnList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        xReq.setUserData("COLUMN_YN", "0");

        if (dao.updateGridConfig(xReq) == 0) {
            dao.createGridConfig(xReq);
        }

        dao.deleteGridColumnList(xReq);
    }

    /**
     * 그리드 정렬 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveGridSortingList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_configInfo_" + xReq.getParam("GRID_ID"), dao.retrieveGridConfig(xReq));
        result.set("ds_sortingList_" + xReq.getParam("GRID_ID"), dao.retrieveGridSortingList(xReq));

        return result;
    }

    /**
     * 그리드 정렬 목록 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateGridSortingList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        xReq.setUserData("SORTING_YN", "1");

        if (dao.updateGridConfig(xReq) == 0) {
            dao.createGridConfig(xReq);
        }

        dao.deleteGridSortingList(xReq);
        dao.createGridSortingList(xReq);
    }

    /**
     * 그리드 정렬 목록 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteGridSortingList(AjaxRequest xReq) throws NException
    {
        GridConfigDao dao = new GridConfigDao(this.nsr);

        xReq.setUserData("SORTING_YN", "0");

        if (dao.updateGridConfig(xReq) == 0) {
            dao.createGridConfig(xReq);
        }

        dao.deleteGridSortingList(xReq);
    }
}
