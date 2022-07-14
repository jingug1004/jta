package anyfive.ipims.patent.rivalpat.dataupload.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class DataUploadDao extends NAbstractServletDao
{
    public DataUploadDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * Data업로드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveRivalPatDataUploadList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/retrieveRivalPatDataUploadList");
        dao.bind(xReq);

        // WIPS키
        if (xReq.getParam("APP_MAN").equals("") != true) {
            dao.addQuery("appMan");
        }

        // 발명의명칭
        if (xReq.getParam("TITLE").equals("") != true) {
            dao.addQuery("title");
        }

        // 업로드일자
        if (xReq.getParam("DATE_START").equals("") != true) {
            dao.addQuery("dateStart");
        }
        if (xReq.getParam("DATE_END").equals("") != true) {
            dao.addQuery("dateEnd");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 자사Data업로드 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData patDataUploadList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/patDataUploadList");
        dao.bind(xReq);

        // PAT_APP_NO
        if (xReq.getParam("PAT_APP_NO").equals("") != true) {
            dao.addQuery("appNo");
        }

        // 명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("title");
        }

        // IPC_CODE
        if (xReq.getParam("IPC_CLS_CODE").equals("") != true) {
            dao.addQuery("ipcCode");
        }



        return dao.executeQueryForGrid(xReq);
    }

    /**
     * Data 존재여부 확인
     *
     * @param data
     * @return
     * @throws NException
     */
    public String retrievePatExist(NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/retrievePatExist");
        dao.bind(data);

        return dao.executeQueryForString();
    }

    /**
     * 자사 Data 존재여부 확인
     *
     * @param data
     * @return
     * @throws NException
     */
    public String retrieveInPatExist(NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/retrieveInPatExist");
        dao.bind(data);

        return dao.executeQueryForString();
    }

    /**
     * Data 생성
     *
     * @param data
     * @return
     * @throws NException
     */
    public int createRivalPatData(NSingleData data ) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/createRivalPatData");
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * Data 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateRivalPatData(NSingleData data ) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/updateRivalPatData");
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     *  자사 Data 수정
     *
     * @param data
     * @return
     * @throws NException
     */
    public int updateInPatData(NSingleData data ) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/updateInPatData");
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatIpcCodeAll(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/deleteRivalPatIpcCodeAll");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createRivalPatIpcCode(String mgtId, NSingleData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/createRivalPatIpcCode");
        dao.bind("MGT_ID", mgtId);
        dao.bind(data);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatIpcCode(String mgtId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/rivalpat/dataupload", "/updateRivalPatIpcCode");
        dao.bind("MGT_ID", mgtId);

        return dao.executeUpdate();
    }
}
