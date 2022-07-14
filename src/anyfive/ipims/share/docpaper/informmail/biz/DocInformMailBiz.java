package anyfive.ipims.share.docpaper.informmail.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.framework.mail.biz.MailBiz;
import anyfive.framework.session.SessionUtil;
import anyfive.ipims.share.docpaper.informmail.dao.DocInformMailDao;

public class DocInformMailBiz extends NAbstractServletBiz
{
    public DocInformMailBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 진행서류 알림메일 수신자 목록 검색
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailReceiverSearchList(AjaxRequest xReq) throws NException
    {
        DocInformMailDao dao = new DocInformMailDao(this.nsr);

        return dao.retrieveInformMailReceiverSearchList(xReq);
    }

    /**
     * 진행서류 알림메일 정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInformMailInfo(AjaxRequest xReq) throws NException
    {
        DocInformMailDao dao = new DocInformMailDao(this.nsr);

        NSingleData result = new NSingleData();

        result.set("ds_mainInfo", dao.retrieveInformMailInfo(xReq));

        return result;
    }

    /**
     * 진행서류 알림메일 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createInformMailInfo(AjaxRequest xReq) throws NException
    {
        DocInformMailDao dao = new DocInformMailDao(this.nsr);
        MailBiz mail = new MailBiz(this.nsr);

        NSingleData mainInfo = xReq.getSingleData("ds_mainInfo");
        NMultiData toList = xReq.getMultiData("ds_toList");
        NMultiData ccList = xReq.getMultiData("ds_ccList");
        NSingleData recvInfo = null;

        mail.init();
        mail.setSubject(mainInfo.getString("SUBJECT"));
        mail.setFrom(SessionUtil.getUserInfo(this.nsr).getMailAddr(), SessionUtil.getUserInfo(this.nsr).getEmpHname());
        for (int i = 0; i < toList.getRowSize(); i++) {
            recvInfo = dao.retrieveInformMailRecvInfo(toList.getString(i, "USER_ID"));
            mail.addTo(recvInfo.getString("MAIL_ADDR"), recvInfo.getString("EMP_HNAME"));
        }
        for (int i = 0; i < ccList.getRowSize(); i++) {
            recvInfo = dao.retrieveInformMailRecvInfo(ccList.getString(i, "USER_ID"));
            mail.addCc(recvInfo.getString("MAIL_ADDR"), recvInfo.getString("EMP_HNAME"));
        }
        mail.addBody(mainInfo.getString("BODY").replaceAll("\n", "<BR>\n"));
        mail.create();
    }
}
