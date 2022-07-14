package anyfive.ipims.share.docpaper.inputregno.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class InputRegNoDao extends NAbstractServletDao
{
    public InputRegNoDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 등록정보 입력사항 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInputRegNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputregno", "/retrieveInputRegNo");
        dao.bind(xReq);

        if (xReq.getParam("LIST_SEQ").equals("") != true) {
            dao.addQuery("remark", "remark");
        }

        if (xReq.getParam("PAPER_CODE").equals("") != true) {
            dao.addQuery("paper", "paper");
        }

        return dao.executeQueryForSingle();
    }

    /**
     * 등록정보 입력사항 저장
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateInputRegNo(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/share/docpaper/inputregno", "/updateInputRegNo");
        dao.bind(xReq);
        int result = dao.executeUpdate();

        dao.setQuery("/ipims/share/docpaper/inputregno", "/updateInputRegNoInt");
        dao.bind(xReq);
        dao.executeUpdate();



        return result;
    }
}
