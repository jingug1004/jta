package anyfive.ipims.patent.common.mapping.appmc.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;

public class AppManCodeMappDao extends NAbstractServletDao
{
    public AppManCodeMappDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 출원인 목록 조회
     *
     * @param refId
     * @param mappDiv
     * @return
     * @throws NException
     */
    public NMultiData retrieveAppManCodeList(String refId, String mappDiv) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/appmc", "/retrieveAppManCodeList");
        dao.bind("REF_ID", refId);
        dao.bind("MAPP_DIV", mappDiv);

        return dao.executeQuery();
    }

    /**
     * 출원인 목록 생성
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] createAppManCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {

        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/common/mapping/appmc", "/createAppManCodeList");
        dao.bind("REF_IDT", refId);
        dao.bind("MAPP_DIVT", mappDiv);


        return dao.executeBatch(data, NJobTypeEnum.CREATE);
    }

    /**
     * 출원인 목록 삭제
     *
     * @param refId
     * @param mappDiv
     * @param data
     * @return
     * @throws NException
     */
    public int[] deleteAppManCodeList(String refId, String mappDiv, NMultiData data) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);
        dao.setQuery("/ipims/patent/common/mapping/appmc", "/deleteAppManCodeList");
        dao.bind("REF_IDT", refId);
        dao.bind("MAPP_DIVT", mappDiv);

        return dao.executeBatch(data, NJobTypeEnum.DELETE);
    }


}
