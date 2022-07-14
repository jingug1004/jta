package anyfive.framework.file.dao;

import any.core.dataset.NJobTypeEnum;
import any.core.dataset.NMultiData;
import any.core.dataset.NSingleData;
import any.core.exception.NException;
import any.core.service.common.NServiceResource;
import any.core.service.servlet.dao.NAbstractServletDao;
import any.util.dao.NQueryDao;
import anyfive.framework.ajax.AjaxRequest;

public class FileDao extends NAbstractServletDao
{
    public FileDao(NServiceResource nsr)
    {
        super(nsr);
    }

    /**
     * 파일 목록 조회
     *
     * @param fileId
     * @return
     * @throws NException
     */
    public NMultiData retrieveFileList(String fileId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/file", "/retrieveFileList");
        dao.bind("FILE_ID", fileId);

        return dao.executeQuery();
    }

    /**
     * 파일 다운로드정보 조회
     *
     * @param xReq
     * @return
     * @throws NException
     */
    public NSingleData retrieveFileDownload(AjaxRequest xReq) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/file", "/retrieveFileDownload");
        dao.bind(xReq);

        return dao.executeQueryForSingle();
    }

    /**
     * 파일 생성
     *
     * @param fileInfo
     * @return
     * @throws NException
     */
    public int createFile(NSingleData fileInfo) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/file", "/createFile");
        dao.bind(fileInfo);

        return dao.executeUpdate();
    }

    /**
     * 파일 목록 삭제
     *
     * @param fileList
     * @return
     * @throws NException
     */
    public int[] deleteFileList(NMultiData fileList) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/file", "/deleteFileList");

        return dao.executeBatch(fileList, NJobTypeEnum.DELETE);
    }

    /**
     * 파일 목록 전체삭제
     *
     * @param fileList
     * @return
     * @throws NException
     */
    public int deleteFileListAll(String fileId) throws NException
    {
        NQueryDao dao = new NQueryDao(this.nsr);

        dao.setQuery("/framework/file", "/deleteFileListAll");
        dao.bind("FILE_ID", fileId);

        return dao.executeUpdate();
    }
}
