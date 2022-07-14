package anyfive.ipims.patent.applymgt.priorsearch.result.biz;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.file.biz.FileBiz;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.ipims.patent.applymgt.priorsearch.result.dao.PriorSearchResultDao;
import anyfive.ipims.share.workprocess.biz.WorkProcessBiz;
import anyfive.ipims.share.workprocess.util.WorkProcessConst;

public class PriorSearchResultBiz extends NAbstractServletBiz
{
    public PriorSearchResultBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 선행기술조사 결과 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrievePriorSearchResult(AjaxRequest xReq) throws NException
    {
        PriorSearchResultDao dao = new PriorSearchResultDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrievePriorSearchResult(xReq));

        return result;
    }

    /**
     * 선행기술조사 결과 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchResult(AjaxRequest xReq) throws NException
    {
        PriorSearchResultDao dao = new PriorSearchResultDao(this.nsr);
        FileBiz fileBiz = new FileBiz(this.nsr);

        // 선행기술조사 결과 수정
        if (dao.updatePriorSearchResult(xReq) == 0) {
            // 선행기술조사 결과 생성
            dao.createPriorSearchResult(xReq);

            // 업무프로세스
            WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
            wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.PRSCH_RESULT_INPUT);
        }

        // 조사결과 첨부파일 저장
        fileBiz.updateFileList(xReq.getMultiData("ds_resultFile"));
    }

    /**
     * 선행기술조사 결과 완료
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updatePriorSearchComplete(AjaxRequest xReq) throws NException
    {
        PriorSearchResultDao dao = new PriorSearchResultDao(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        // 선행기술조사 결과 완료
        dao.updatePriorSearchComplete(xReq);

        // 업무프로세스
        WorkProcessBiz wpBiz = new WorkProcessBiz(this.nsr);
        wpBiz.update(xReq.getParam("PRSCH_ID"), WorkProcessConst.Action.PRSCH_RESULT_COMPLETE);

        // 조사결과 통보메일 발송정보 조회
        NSingleData mailInfo = dao.retrievePriorSearchInformMailInfo(xReq);

        // 내부조사인 경우 데이터 없음
        //if (mailInfo.isEmpty()) return;

        // 조사결과 통보메일 발송
        System.out.println("메일 제목===="+mailInfo.getString("MAIL_SUBJECT"));
        System.out.println("발신자 메일 주소===="+mailInfo.getString("TO_ADDR"));
        System.out.println("발신자===="+mailInfo.getString("TO_NAME"));
        mail.init();
        mail.setSubject(mailInfo.getString("MAIL_SUBJECT"));
        mail.addTo(mailInfo.getString("TO_ADDR"), mailInfo.getString("TO_NAME"));
        mail.template.init("/prsch/inform");
        mail.template.setData(mailInfo);
        mail.create();
    }
}
