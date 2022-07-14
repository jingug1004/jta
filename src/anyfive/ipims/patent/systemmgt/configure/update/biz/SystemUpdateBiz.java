package anyfive.ipims.patent.systemmgt.configure.update.biz;

import java.io.File;
import java.util.ArrayList;

import any.core.config.NConfig;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NBizException;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.biz.NAbstractServletBiz;
import any.util.dao.NResultSetConverter;
import any.util.file.NFileUtil;
import any.util.packer.NPackerUtil;
import anyfive.framework.ajax.AjaxRequest;
import anyfive.ipims.patent.systemmgt.configure.update.dao.SystemUpdateDao;
import anyfive.ipims.patent.systemmgt.configure.update.util.SystemUpdateUtil;

public class SystemUpdateBiz extends NAbstractServletBiz
{
    public SystemUpdateBiz(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 업데이트 파일 목록 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUpdateFileList(AjaxRequest xReq) throws NException
    {
        File updateHome = new File(SystemUpdateUtil.getUpdateSourceRoot());

        updateHome.mkdirs();

        File[] files = updateHome.listFiles();
        NMultiData resultList = new NMultiData();

        for (int i = 0; i < files.length; i++) {
            if (files[i].isFile() != true) continue;
            if (files[i].getName().indexOf(".") == -1) continue;
            resultList.addSingleData(SystemUpdateUtil.getFileInfo(files[i]));
        }

        return NResultSetConverter.getGridData(resultList);
    }

    /**
     * 업데이트 파일 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveUpdateFile(AjaxRequest xReq) throws NException
    {
        String pathname = SystemUpdateUtil.getUpdateSourceRoot() + "/" + xReq.getParam("FILE_NAME");

        return SystemUpdateUtil.getFileInfo(new File(pathname));
    }

    /**
     * 업데이트 파일 내용 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public String retrieveUpdateFileContent(AjaxRequest xReq) throws NException
    {
        String pathname = SystemUpdateUtil.getUpdateSourceRoot() + "/" + xReq.getParam("FILE_NAME");

        return NFileUtil.readAll(pathname);
    }

    /**
     * 업데이트 파일 삭제
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public void deleteUpdateFile(AjaxRequest xReq) throws NException
    {
        String pathname = SystemUpdateUtil.getUpdateSourceRoot() + "/" + xReq.getParam("FILE_NAME");

        NFileUtil.deleteFile(pathname);
    }

    /**
     * 시스템 데이터베이스 스키마 업데이트
     *
     * @param pathname
     * @param deleteFile
     * @throws NException
     */
    public void updateSystemDBSchema(String pathname, boolean deleteFile) throws NException
    {
        SystemUpdateDao dao = new SystemUpdateDao(this.nsr);

        dao.executeSystemUpdate(NFileUtil.readAll(pathname));

        if (deleteFile) NFileUtil.deleteFile(pathname);
    }

    /**
     * 시스템 데이터베이스 데이터 업데이트
     *
     * @param pathname
     * @param deleteFile
     * @throws NException
     */
    public void updateSystemDBData(String pathname, boolean deleteFile) throws NException
    {
        SystemUpdateDao dao = new SystemUpdateDao(this.nsr);

        String[] queries = NFileUtil.readAll(pathname).split(";");

        for (int i = 0; i < queries.length; i++) {
            if (queries[i] == null || queries[i].trim().equals("")) continue;
            dao.executeSystemUpdate(queries[i].trim());
        }

        if (deleteFile) NFileUtil.deleteFile(pathname);
    }

    /**
     * 시스템 프로그램 업데이트
     *
     * @param pathname
     * @param deleteFile
     * @param cleanTarget
     * @throws NException
     */
    public void updateSystemProgram(String pathname, boolean deleteFile) throws NException
    {
        String targetRoot = NConfig.getPathName("/config/update/target/root");

        if (targetRoot.equals("")) {
            throw new NBizException("업데이트 대상폴더가 정의되지 않았습니다.");
        }

        if (new File(targetRoot).exists() != true) {
            throw new NBizException("업데이트 대상폴더 [" + targetRoot + "] 가 존재하지 않습니다.");
        }

        String sourceRoot = SystemUpdateUtil.getUpdateSourceRoot() + "/" + new File(pathname).getName().replaceAll("\\.", "_") + "_temp";

        NFileUtil.deleteDirectory(sourceRoot);

        NPackerUtil.extractZipFile(pathname, sourceRoot);

        ArrayList<?> updateList = NConfig.getKeyNameList("/config/update/target/update");

        for (int i = 0; i < updateList.size(); i++) {
            NFileUtil.copyDirectory(sourceRoot + updateList.get(i), targetRoot + NConfig.getString("/config/update/target/update[@name=\"" + updateList.get(i) + "\"]"));
        }

        NFileUtil.deleteDirectory(sourceRoot);

        if (deleteFile) NFileUtil.deleteFile(pathname);
    }
}
