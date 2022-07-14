package anyfive.framework.mail.biz;

import javax.mail.Message;

import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.mail.NMailTemplate;
import anyfive.framework.mail.dao.MailDao;
import anyfive.framework.sequence.biz.SequenceBiz;

public class MailBiz extends NAbstractServletBiz
{
    private static final String DEFAULT_MAIL_HOST = NConfig.getString("/config/e-mail/default-host-name");

    private String              mailId            = null;
    private StringBuffer        bodyBuffer        = null;
    private NSingleData         mailInfo          = null;
    private NMultiData          recvList          = null;

    public NMailTemplate        template          = null;

    public MailBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 초기화
     */
    public void init()
    {
        this.mailId = null;
        this.bodyBuffer = new StringBuffer();
        this.mailInfo = new NSingleData();
        this.recvList = new NMultiData();

        this.template = new NMailTemplate();

        this.setFrom(NConfig.getString("/config/e-mail/default-from-addr"), NConfig.getString("/config/e-mail/default-from-name"));
    }

    /**
     * 메일ID 반환
     *
     * @param subject
     */
    public String getMailId()
    {
        return this.mailId;
    }

    /**
     * 메일제목 반환
     *
     * @param subject
     */
    public String getSubject()
    {
        return this.mailInfo.getString("SUBJECT");
    }

    /**
     * 메일제목 설정
     *
     * @param subject
     */
    public void setSubject(String subject)
    {
        this.mailInfo.setString("SUBJECT", subject);
    }

    /**
     * 보내는사람 설정
     *
     * @param addr
     * @param name
     * @throws NException
     */
    public void setFrom(String addr, String name)
    {
        if (addr != null && addr.equals("") != true) {
            this.mailInfo.setString("FROM_ADDR", this.getFullAddr(addr));
        }

        if (name != null && name.equals("") != true) {
            this.mailInfo.setString("FROM_NAME", name);
        }
    }

    /**
     * 수신자 추가
     *
     * @param addr
     * @param name
     */
    public void addTo(String addr, String name)
    {
        this.addRecv(Message.RecipientType.TO, addr, name);
    }

    /**
     * 참조자 추가
     *
     * @param addr
     * @param name
     */
    public void addCc(String addr, String name)
    {
        this.addRecv(Message.RecipientType.CC, addr, name);
    }

    /**
     * 숨은참조자 추가
     *
     * @param addr
     * @param name
     */
    public void addBcc(String addr, String name)
    {
        this.addRecv(Message.RecipientType.BCC, addr, name);
    }

    /**
     * 받는사람 추가
     *
     * @param type
     * @param addr
     * @param name
     */
    private void addRecv(Message.RecipientType type, String addr, String name)
    {
        if (addr == null || addr.equals("")) return;

        int row = this.recvList.addRow();

        this.recvList.setInt(row, "RECV_SEQ", row + 1);
        this.recvList.setString(row, "RECV_TYPE", type.toString().toUpperCase());
        this.recvList.setString(row, "RECV_ADDR", this.getFullAddr(addr));
        this.recvList.setString(row, "RECV_NAME", name);
    }

    /**
     * 메일주소 반환
     *
     * @param addr
     * @return
     */
    private String getFullAddr(String addr)
    {
        if (addr == null || addr.equals("")) return null;
        if (addr.indexOf("@") != -1) return addr;

        return addr + DEFAULT_MAIL_HOST;
    }

    /**
     * 메일내용 추가
     *
     * @param body
     */
    public void addBody(String body)
    {
        this.bodyBuffer.append(body);
    }

    /**
     * 메일내용 반환
     *
     * @return
     */
    public String getBody()
    {
        if (this.template == null) return this.bodyBuffer.toString();

        return this.template.toString() + this.bodyBuffer.toString();
    }

    /**
     * 메일 생성
     *
     * @return 메일ID
     * @throws NException
     */
    public String create() throws NException
    {
        MailDao dao = new MailDao(this.nsr);
        SequenceBiz seq = new SequenceBiz(this.nsr);

        this.mailId = seq.getMailId();

        dao.createMail(this.mailId, this.mailInfo);
        dao.updateMailBody(this.mailId, this.getBody());
        dao.createMailRecvList(this.mailId, this.recvList);
        dao.createMailLog(this.mailId);

        return this.mailId;
    }
}
