package anyfive.ipims.patent.rivalpat.dataupload.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.rivalpat.dataupload.dao.DataUploadDao;
import anyfive.ipims.share.common.util.SequenceUtil;

public class DataUploadBiz extends NAbstractServletBiz
{
    public DataUploadBiz(NServiceResource nsr)
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
        DataUploadDao dao = new DataUploadDao(this.nsr);

        return dao.retrieveRivalPatDataUploadList(xReq);
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
        DataUploadDao dao = new DataUploadDao(this.nsr);

        return dao.patDataUploadList(xReq);
    }

    /**
     * Data업로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String uploadExcel(AjaxRequest xReq) throws NException
    {
        DataUploadDao dao = new DataUploadDao(this.nsr);
        SequenceUtil seqUtil = new SequenceUtil(this.nsr);

        NSingleData ds = xReq.getSingleData("ds");

        String mgtId = dao.retrievePatExist(ds);
        String result = null;

        if (mgtId == null || mgtId.equals("") == true) {
            System.out.println("CREATE!");
            mgtId = seqUtil.getRivalPatMgtId();
            ds.setString("MGT_ID", mgtId);
            dao.createRivalPatData(ds);
            result = "C";

            // IPC분류코드 생성
            dao.createRivalPatIpcCode(mgtId, ds);
            dao.updateRivalPatIpcCode(mgtId);

        } else {
            System.out.println("UPDATE!");
            ds.setString("MGT_ID", mgtId);
            dao.updateRivalPatData(ds);
            result = "U";

            // IPC분류코드 수정
            dao.deleteRivalPatIpcCodeAll(mgtId);
            dao.createRivalPatIpcCode(mgtId, ds);
            dao.updateRivalPatIpcCode(mgtId);
        }

        return result;
    }

    /**
     * 자사 Data업로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String uploadInExcel(AjaxRequest xReq) throws NException
    {
        DataUploadDao dao = new DataUploadDao(this.nsr);

        NSingleData ds = xReq.getSingleData("ds");

        String refId = dao.retrieveInPatExist(ds);
        String result = null;

        System.out.println("UPDATE!");
        ds.setString("REF_ID", refId);
        dao.updateInPatData(ds);
        result = "U";


        return result;
    }
}
