package anyfive.ipims.patent.systemmgt.configure.message.biz;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.message.dao.MessageDao;

public class MessageBiz extends NAbstractServletBiz
{
    public MessageBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 메세지 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveMessageList(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        return dao.retrieveMessageList(xReq);
    }

    /**
     * 메세지 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NMultiData retrieveMessage(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        return dao.retrieveMessage(xReq);
    }

    /**
     * 메세지 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void createMessage(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        if (dao.retrieveMessageExists(xReq) == true) {
            throw new NBizException(1, this.nsr.message.get("msg.com.error.dup"));
        }

        dao.createMessage(xReq);
    }

    /**
     * 메세지 수정
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void updateMessage(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        dao.deleteMessage(xReq);
        dao.createMessage(xReq);
    }

    /**
     * 메세지 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteMessage(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        dao.deleteMessage(xReq);
    }

    /**
     * 메세지 업로드
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void uploadMessage(AjaxRequest xReq) throws NException
    {
        MessageDao dao = new MessageDao(this.nsr);

        NSingleData ds = xReq.getSingleData("ds");
        String msgId = ds.getString("Message ID");

        NMultiData messageList = new NMultiData();
        int row = -1;

        for (int i = 0; i < ds.getKeySize(); i++) {
            if (ds.getKey(i).equals("Message ID") == true) continue;
            if (ds.getString(ds.getKey(i)).trim().equals("")) continue;
            row = messageList.addRow();
            messageList.setString(row, "LANG_CODE", ds.getKey(i));
            messageList.setString(row, "MSG_TEXT", ds.getString(ds.getKey(i)));
        }

        xReq.setUserData("DEL_MSG_ID", msgId);

        dao.deleteMessage(xReq);
        dao.createMessage(msgId, messageList);
    }
}
