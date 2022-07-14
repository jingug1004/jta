package anyfive.ipims.patent.systemmgt.configure.message.dao;

import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class MessageDao extends NAbstractServletDao
{
    public MessageDao(NServiceResource nsr)
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/retrieveMessageList");
        dao.bind(xReq);

        if (xReq.getParam("SEARCH_TEXT").equals("") != true) {
            dao.addQuery("searchText");
        }

        return dao.executeQueryForGrid(xReq);
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
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/retrieveMessage");
        dao.bind(xReq);

        return dao.executeQuery();
    }

    /**
     * 메세지 중복여부 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public boolean retrieveMessageExists(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/retrieveMessageExists");
        dao.bind(xReq);

        return (dao.executeQueryForString().equals("0") != true);
    }

    /**
     * 메세지 생성
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int[] createMessage(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/createMessage");
        dao.bind(xReq);

        return dao.executeBatch(xReq.getMultiDataWithoutDeleteRow("ds_messageList"));
    }

    /**
     * 메세지 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public int deleteMessage(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/deleteMessage");
        dao.bind(xReq);

        return dao.executeUpdate();
    }

    /**
     * 메세지 생성
     *
     * @param msgId
     * @param messageList
     * @return
     * @throws NException
     */
    public int[] createMessage(String msgId, NMultiData messageList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/systemmgt/configure/message", "/createMessage");
        dao.bind("MSG_ID", msgId);

        return dao.executeBatch(messageList);
    }
}
