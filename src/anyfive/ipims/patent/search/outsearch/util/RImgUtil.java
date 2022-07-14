package anyfive.ipims.patent.search.outsearch.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import any.util.envmap.NEnvMapUtil;
import any.util.etc.NHttpUtil;
import any.util.etc.NTextUtil;
import any.util.file.NFileDownload;

import com.sun.media.jai.codec.SeekableStream;

public class RImgUtil
{
    public static RenderedImage getKRImage(String an) throws Exception
    {
        NHttpUtil http = new NHttpUtil();

        http.init("http://patent2.kipris.or.kr/pat/fulltexta.do?method=bigFrontDraw&applno=" + an, "euc-kr");
        http.send();

        if (isNoImage(http.getResponseText())) return null;

        http.init("http://patent2.kipris.or.kr" + NTextUtil.crop(http.getResponseText(), "<img src=\"", "\""));
        http.send();

        return JAI.create("Stream", SeekableStream.wrapInputStream(http.getURLConnection().getInputStream(), true));
    }

    public static RenderedImage getABImage(String an) throws Exception
    {
        NHttpUtil http = new NHttpUtil();

        http.init("http://abroad.kipris.or.kr/fpat/fulltexta.do?method=bigFrontDraw&publ_key=US20020090612B2&cntry=UP", "euc-kr");
        http.send();

        if (isNoImage(http.getResponseText())) return null;

        http.init("http://abroad.kipris.or.kr" + NTextUtil.crop(http.getResponseText(), "GetBigEmbed('", "');"));
        http.send();

        return JAI.create("Stream", SeekableStream.wrapInputStream(http.getURLConnection().getInputStream(), true));
    }

    public static RenderedImage resize(RenderedImage img, int width, int height, boolean fixedRatio)
    {
        BufferedImage orgImg = ((RenderedOp)img).getAsBufferedImage();

        int newLeft = 0;
        int newTop = 0;
        int newWidth = 0;
        int newHeight = 0;

        if (fixedRatio) {
            double orgWidth = orgImg.getWidth();
            double orgHeight = orgImg.getHeight();
            double zoomWidth = orgWidth / width;
            double zoomHeight = orgHeight / height;
            if (zoomWidth == zoomHeight) {
                newWidth = width;
                newHeight = height;
            } else {
                double zoomRatio = Math.max(zoomWidth, zoomHeight);
                if (zoomWidth > zoomHeight) {
                    newWidth = width;
                    newHeight = (int)(orgHeight / zoomRatio);
                } else {
                    newWidth = (int)(orgWidth / zoomRatio);
                    newHeight = height;
                }
            }
        } else {
            newWidth = width;
            newHeight = height;
        }

        newLeft = (width - newWidth) / 2;
        newTop = (height - newHeight) / 2;

        BufferedImage outImg = new BufferedImage(width, height, orgImg.getType());
        Graphics2D g2 = outImg.createGraphics();

        try {
            g2.drawImage(ImageIO.read(new File(NEnvMapUtil.getEnvPath("filetemplate") + "/image/white.gif")), 0, 0, outImg.getWidth(), outImg.getHeight(), null);
        } catch (IOException e) {
            e.printStackTrace();
        }

        g2.drawImage(orgImg.getScaledInstance(newWidth, newHeight, Image.SCALE_AREA_AVERAGING), newLeft, newTop, newWidth, newHeight, null);

        return outImg;
    }

    public static void flushToJpeg(HttpServletResponse res, RenderedImage img)
    {
        res.reset();
        res.setContentType("application/octet-stream");
        res.setHeader("Accept-Ranges", "bytes");

        try {
            ImageIO.write(img, "jpg", res.getOutputStream());
        } catch (IOException e) {
        }
    }

    public static void downloadToJpeg(HttpServletRequest req, HttpServletResponse res, RenderedImage img, String downloadFileName)
    {
        try {
            new NFileDownload(req, res).setHeader(downloadFileName);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            ImageIO.write(img, "jpg", res.getOutputStream());
        } catch (IOException e) {
        }
    }

    private static boolean isNoImage(String text)
    {
        if (text.indexOf("noimage") != -1) return true;
        if (text.indexOf("no_image") != -1) return true;
        if (text.indexOf("no-image") != -1) return true;

        return false;
    }
}
