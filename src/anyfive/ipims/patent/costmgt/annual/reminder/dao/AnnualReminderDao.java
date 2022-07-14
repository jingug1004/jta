package anyfive.ipims.patent.costmgt.annual.reminder.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class AnnualReminderDao extends NAbstractServletDao
{
    public AnnualReminderDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 연차 Reminder 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualReminderList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/reminder", "/retrieveAnnualReminderList");
        dao.bind(xReq);

        // 권리구분
        if (xReq.getParam("RIGHT_DIV").equals("") != true) {
            dao.addQuery("rightDiv");
        }

        // 연차료구분
        if (xReq.getParam("ANNUAL_DIV").equals("") != true) {
            dao.addQuery("annualDiv");
        }

        // 번호검색
        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            if (xReq.getParam("SEARCH_TYPE").equals("REF_NO")) {
                dao.addQuery("refNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("APP_NO")) {
                dao.addQuery("appNo");
            }
            if (xReq.getParam("SEARCH_TYPE").equals("REG_NO")) {
                dao.addQuery("regNo");
            }
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

        // 발명의명칭
        if (xReq.getParam("KO_APP_TITLE").equals("") != true) {
            dao.addQuery("koAppTitle");
        }

        return dao.executeQueryForGrid(xReq);
    }

    /**
     * 연차 Reminder 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveAnnualReminder(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/reminder", "/retrieveAnnualReminder");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 연차 Reminder 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int createAnnualReminder(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/reminder", "/createAnnualReminder");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연차 Reminder 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int updateAnnualReminder(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/reminder", "/updateAnnualReminder");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 연차 Reminder 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteAnnualReminder(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/costmgt/annual/reminder", "/deleteAnnualReminder");
        dao.bind(xReq);

        return dao.executeUpdate();
    }
}
