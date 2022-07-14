package anyfive.ipims.patent.applymgt.program.consult.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class ProgramConsultDao extends NAbstractServletDao
{
    public ProgramConsultDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 프로그램품의 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramConsultList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/consult", "/retrieveProgramConsultList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SEARCH_TYPE").equals("") != true && xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_TYPE").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
        }

        if (xReq.getParam("SEARCH_NO_ONLY").equals("1") != true) {

            // 검색일자
            if (xReq.getParam("DATE_GUBUN").equals("") != true) {
                if (xReq.getParam("DATE_START").equals("") != true) {
                    dao.addQuery("dateStart");
                }
                if (xReq.getParam("DATE_END").equals("") != true) {
                    dao.addQuery("dateEnd");
                }
            }

            // 발명자
            if (xReq.getParam("INV_TYPE").equals("") != true && xReq.getParam("INV_TEXT").equals("") != true) {
                if (xReq.getParam("INV_TYPE").equals("NAME") == true) {
                    dao.addQuery("invName");
                }
                if (xReq.getParam("INV_TYPE").equals("EMP_NO") == true) {
                    dao.addQuery("invEmpno");
                }
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 프로그램품의 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveProgramConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/consult", "/retrieveProgramConsult");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 프로그램품의서 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createProgramConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/consult", "/createProgramConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 프로그램품의 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateProgramConsult(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/program/consult", "/updateProgramConsult");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
