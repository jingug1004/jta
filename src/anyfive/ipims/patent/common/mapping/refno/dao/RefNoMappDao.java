package anyfive.ipims.patent.common.mapping.refno.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class RefNoMappDao extends NAbstractServletDao
{
    public RefNoMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * REF-NO 목록 조회
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveRefNoList(String grpId, String mappKind, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/refno", "/retrieveRefNoList");
        dao.bind("GRP_ID", grpId);
        dao.bind("MAPP_KIND", mappKind);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * REF-NO 목록 생성
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] createRefNoList(String grpId, String mappKind, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/refno", "/createRefNo");
        dao.bind("GRP_ID", grpId);
        dao.bind("MAPP_KIND", mappKind);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * REF-NO 목록 삭제
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteRefNoList(String grpId, String mappKind, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/refno", "/deleteRefNo");
        dao.bind("GRP_ID", grpId);
        dao.bind("MAPP_KIND", mappKind);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }

    /**
     * REF-NO 목록 전체 삭제
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @return
     * @throws NException
     */
    public int deleteRefNoListAll(String grpId, String mappKind, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/refno", "/deleteRefNoListAll");
        dao.bind("GRP_ID", grpId);
        dao.bind("MAPP_KIND", mappKind);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeUpdate();
    }

    /**
     * 출원마스터(국내)의 해외출원상태 업데이트
     *
     * @param data
     * @return
     * @throws NException
     */
    public int[] updateIntMasterExtAppStatus(NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/refno", "/updateIntMasterExtAppStatus");

        return dao.executeBatch(data);
    }
}
