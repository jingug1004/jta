package anyfive.ipims.share.docpaper.inputappno.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class InputAppNoDao extends NAbstractServletDao
{
    public InputAppNoDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원정보 입력사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInputAppNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/retrieveInputAppNo");
        dao.bind(xReq);

        if (xReq.getParam("LIST_SEQ").equals("") != true) {
            dao.addQuery("remark", "remark");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 출원정보 입력사항 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateInputAppNo(AjaxRequest xReq,String ipcCode) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/updateInputAppNo");
        dao.bind(xReq);
        dao.bind("IPC_CLS_CODE", ipcCode);
        int result = dao.executeUpdate();

        dao.setQuery("/ipims/share/docpaper/inputappno", "/updateInputAppNoInt");
        dao.bind(xReq);
        dao.executeUpdate();

        return result;
    }

    /**
     * IPC분류코드 전체 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteRivalPatIpcCodeAll(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/deleteRivalPatIpcCodeAll");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }

    /**
     * IPC분류코드 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createRivalPatIpcCode(String refId, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/createRivalPatIpcCode");
        dao.bind("REF_ID", refId);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * IPC분류코드 주분류 설정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateRivalPatIpcCode(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/updateRivalPatIpcCode");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }


    public int selectRivalPatIpcCode(String refId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputappno", "/selectRivalPatIpcCode");
        dao.bind("REF_ID", refId);

        return dao.executeUpdate();
    }
}
