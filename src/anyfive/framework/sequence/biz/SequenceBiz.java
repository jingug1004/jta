package anyfive.framework.sequence.biz;

import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.etc.NTextUtil;
import anyfive.framework.sequence.dao.SequenceDao;

public class SequenceBiz extends NAbstractServletBiz
{
    public SequenceBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * Oracle Sequence 조회
     *
     * @param oracleSequenceName
     * @param length
     * @return
     * @throws NException
     */
    public String get(String oracleSequenceName, int length) throws NException
    {
        if (oracleSequenceName == null || oracleSequenceName.equals("")) return null;

        SequenceDao dao = new SequenceDao(this.nsr);

        String seqNo = dao.retrieveOracleSequence(oracleSequenceName);

        return NTextUtil.lpad(seqNo, length, "0");
    }

    /**
     * SEQ NO 조회
     *
     * @param type
     * @param header
     * @param length
     * @param join
     * @return
     * @throws NException
     */
    public String get(String type, String header, int length, String join) throws NException
    {
        if (type == null || type.equals("")) return null;

        SequenceDao dao = new SequenceDao(this.nsr);

        if (header == null || header.equals("")) header = type;

        String seqNo = dao.retrieveSequence(type, header);

        if (seqNo.equals("")) {
            seqNo = "1";
            dao.createSequence(type, header, seqNo);
        } else {
            dao.updateSequence(type, header, seqNo);
        }

        seqNo = NTextUtil.lpad(seqNo, length, "0");

        if (join == null) return seqNo;

        return header + join + seqNo;
    }

    /**
     * 메일 ID
     *
     * @return
     * @throws NException
     */
    public String getMailId() throws NException
    {
        return this.get("MAIL_ID", null, -1, null);
    }

    /**
     * 파일 ID
     *
     * @return
     * @throws NException
     */
    public String getFileId() throws NException
    {
        return this.get("FILE_ID", null, 12, null);
    }
}
