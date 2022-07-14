package anyfive.ipims.patent.search.outsearch.act;

import java.awt.image.RenderedImage;

import javax.media.jai.JAI;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.core.service.common.NServiceResource;
import any.core.service.servlet.act.NAbstractServletAct;
import any.util.envmap.NEnvMapUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.search.outsearch.util.RImgUtil;

/**
 * 대표도면 조회
 */
public class RetrieveRImg implements NAbstractServletAct
{
    public void execute(HttpServletRequest req, HttpServletResponse res, NServiceResource nsr) throws Exception
    {
        AjaxRequest xReq = new AjaxRequest(req);

        String cc = xReq.getParam("cc");
        String an = xReq.getParam("an");
        boolean isThumbnail = xReq.getParam("thumbnail").equals("1");
        boolean isDownload = xReq.getParam("download").equals("1");

        String imgName = an + ".jpg";
        RenderedImage img = null;

        if (cc.equals("KR")) {
            img = RImgUtil.getKRImage(an);
        } else {
            img = RImgUtil.getABImage(an);
        }

        if (img == null) {
            imgName = "no_image.jpg";
            img = JAI.create("FileLoad", NEnvMapUtil.getEnvPath("filetemplate") + "/image/noimage.gif");
        }

        if (isThumbnail) {
            img = RImgUtil.resize(img, 120, 120, true);
        }

        if (isDownload) {
            RImgUtil.downloadToJpeg(req, res, img, imgName);
        } else {
            RImgUtil.flushToJpeg(res, img);
        }
    }
}
