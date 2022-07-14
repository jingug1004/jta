package anyfive.ipims.patent.costmgt.annual.reminder.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.costmgt.annual.reminder.dao.AnnualReminderDao;

public class AnnualReminderBiz extends NAbstractServletBiz
{
    public AnnualReminderBiz(NServiceResource nsr)
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
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        return dao.retrieveAnnualReminderList(xReq);
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
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        return dao.retrieveAnnualReminder(xReq);
    }

    /**
     * 연차 Reminder 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createAnnualReminder(AjaxRequest xReq) throws NException
    {
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        if (dao.createAnnualReminder(xReq) == 0) {
            throw new NBizException("Reminder를 생성할 수 없습니다.\n\n존재하지 않는 REF-NO이거나 중복된 Reminder입니다.");
        }
    }

    /**
     * 연차 Reminder 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateAnnualReminder(AjaxRequest xReq) throws NException
    {
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        dao.updateAnnualReminder(xReq);
    }

    /**
     * 연차 Reminder 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteAnnualReminder(AjaxRequest xReq) throws NException
    {
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        if (dao.deleteAnnualReminder(xReq) == 0) {
            throw new NBizException("Reminder를 삭제할 수 없습니다.\n\n이미 평가가 진행중인 Reminder입니다.");
        }
    }

    /**
     * 연차 Reminder 업로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String uploadAnnualReminder(AjaxRequest xReq) throws NException
    {
        AnnualReminderDao dao = new AnnualReminderDao(this.nsr);

        NSingleData ds = xReq.getSingleData("ds");

        ds.setString("REF_NO", ds.getString("등록번호"));
        ds.setString("ORG_PAY_YEARDEG", ds.getString("납부년차"));
        ds.setString("PAY_YEARDEG", ds.getString("납부년차"));
        ds.setString("PAY_LIMIT", ds.getString("납부기한"));
        ds.setString("NEXT_PAY_YEARDEG", ds.getString("차기 납부년차"));
        ds.setString("NEXT_PAY_LIMIT", ds.getString("차기 납부기한"));
        ds.setString("GOVERNMENT_PAY", ds.getString("관납료"));
        ds.setString("TOTAL_CLAIM", ds.getString("총항수"));

        String result = null;

        if (dao.updateAnnualReminder(xReq) == 0) {
            if (dao.createAnnualReminder(xReq) == 0) {
                throw new NBizException("Reminder를 생성할 수 없습니다.\n\n존재하지 않는 REF-NO이거나 중복된 Reminder입니다.");
            }
            result = "C";
        } else {
            result = "U";
        }

        return result;
    }
}
