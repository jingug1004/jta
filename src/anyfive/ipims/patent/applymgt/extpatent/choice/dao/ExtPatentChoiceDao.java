package anyfive.ipims.patent.applymgt.extpatent.choice.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ExtPatentChoiceDao extends NAbstractServletDao
{
    public ExtPatentChoiceDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 해외출원품의대상 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveExtPatentChoiceList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/extpatent/choice", "/retrieveExtPatentChoiceList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("NO_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            if (xReq.getParam("NO_GUBUN").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("PAT_NO")) {
                dao.addQuery("patNo");
            }
            if(xReq.getParam("NO_GUBUN").equals("REG_NO")) {
                dao.addQuery("regNO");
            }
        }

        if(xReq.getParam("SR_NO_ONLY").equals("1") != true){

            // 권리구분
            if (xReq.getParam("RIGHT_DIV").equals("") != true) {
                dao.addQuery("rightDiv");
            }

            // 사무소
            if (xReq.getParam("OFFICE_CODE").equals("") != true) {
                dao.addQuery("officeCode");
            }

            // 건담당자
            if (xReq.getParam("JOB_MAN").equals("") != true) {
                dao.addQuery("jobMan");
            }

            // 해외품의상태
            if (xReq.getParam("EXT_APP_STATUS").equals("") != true) {
                dao.addQuery("extAppStatus");
            }

            // 출원기한
            if (xReq.getParam("EXT_APP_LIMIT").equals("") != true) {
                dao.addQuery("extAppLimit");
            }

            // 검색일자
            if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                if (xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("DATE_END").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }
}
