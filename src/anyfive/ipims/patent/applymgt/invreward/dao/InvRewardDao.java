package anyfive.ipims.patent.applymgt.invreward.dao;

import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class InvRewardDao extends NAbstractServletDao
{
    public InvRewardDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 발명자별 보상금지급조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveInvRewardList(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/ipims/patent/applymgt/invreward/invreward", "/retrieveInvRewardList");
        dao.bind(xReq);

        // 번호검색
        if (xReq.getParam("SR_GUBUN").equals("") != true && xReq.getParam("SR_NO").equals("") != true) {
            dao.addQuery("searchNo");
        }

        // 보상금 구분
        if (xReq.getParam("REWARD_DIV").equals("") != true) {
            dao.addQuery("rewardDiv");
        }

        // 번호검색
        if (xReq.getParam("INOUT_DIV").equals("") != true) {
            dao.addQuery("inoutDiv");
        }

        // 검색일자
        if (xReq.getParam("DATE_GUBUN").equals("") != true) {
            if (xReq.getParam("DATE_START").equals("") != true) {
                dao.addQuery("dateStart");
            }
            if (xReq.getParam("DATE_END").equals("") != true) {
                dao.addQuery("dateEnd");
            }
        }

        return dao.executeQueryForGrid(xReq);
    }

}
