package anyfive.framework.sequence.dao;

import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class SequenceDao extends NAbstractServletDao
{
    public SequenceDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * Oracle Sequence 조회
     *
     * @param name
     * @return
     * @throws NException
     */
    public String retrieveOracleSequence(String name) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/sequence", "/retrieveOracleSequence");
        dao.replaceText("NAME", name);

        return dao.executeQueryForString();
    }

    /**
     * Sequence 조회
     *
     * @param type
     * @param header
     * @return
     * @throws NException
     */
    public String retrieveSequence(String type, String header) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/sequence", "/retrieveSequence");
        dao.bind("SEQ_TYPE", type);
        dao.bind("SEQ_HEADER", header);

        return dao.executeQueryForString();
    }

    /**
     * Sequence 생성
     *
     * @param type
     * @param header
     * @param seqNo
     * @return
     * @throws NException
     */
    public int createSequence(String type, String header, String seqNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/sequence", "/createSequence");
        dao.bind("SEQ_TYPE", type);
        dao.bind("SEQ_HEADER", header);
        dao.bind("SEQ_NO", seqNo);

        return dao.executeUpdate();
    }

    /**
     * Sequence 수정
     *
     * @param type
     * @param header
     * @param seqNo
     * @return
     * @throws NException
     */
    public int updateSequence(String type, String header, String seqNo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/sequence", "/updateSequence");
        dao.bind("SEQ_TYPE", type);
        dao.bind("SEQ_HEADER", header);
        dao.bind("SEQ_NO", seqNo);

        return dao.executeUpdate();
    }
}
