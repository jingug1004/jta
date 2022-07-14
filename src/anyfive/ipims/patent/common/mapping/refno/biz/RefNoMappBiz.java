package anyfive.ipims.patent.common.mapping.refno.biz;

import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import anyfive.ipims.patent.common.mapping.consts.MappingKind;
import anyfive.ipims.patent.common.mapping.refno.dao.RefNoMappDao;

public class RefNoMappBiz extends NAbstractServletBiz
{
    public RefNoMappBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * REF_NO 목록 조회
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveRefNoList(String grpId, String mappKind, String mappDiv) throws NException
    {
        RefNoMappDao dao = new RefNoMappDao(this.nsr);

        return dao.retrieveRefNoList(grpId, mappKind, mappDiv);
    }

    /**
     * REF_NO 목록 저장
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @param data
     * @throws NException
     */
    public void updateRefNoList(String grpId, String mappKind, String mappDiv, NMultiData data) throws NException
    {
        RefNoMappDao dao = new RefNoMappDao(this.nsr);

        dao.deleteRefNoList(grpId, mappKind, mappDiv, data);
        dao.createRefNoList(grpId, mappKind, mappDiv, data);

        //해외그룹의 REF_NO인 경우 국내출원마스터의 해외출원상태를 '1'로 업데이트
        if (mappKind.equals(MappingKind.GROUP)) {
            dao.updateIntMasterExtAppStatus(data);
        }
    }

    /**
     * REF_NO 목록 전체 삭제
     *
     * @param grpId
     * @param mappKind
     * @param mappDiv
     * @throws NException
     */
    public void deleteRefNoListAll(String grpId, String mappKind, String mappDiv) throws NException
    {
        RefNoMappDao dao = new RefNoMappDao(this.nsr);

        dao.deleteRefNoListAll(grpId, mappKind, mappDiv);
    }
}
