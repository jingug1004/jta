package anyfive.framework.file.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.SocketException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import any.core.exception.NException;
import any.core.exception.NSysException;

/**
 * FTP Util
 */
public class FTPUtil
{
    private final FTPClient ftpClient;

    public FTPUtil()
    {
        ftpClient = new FTPClient();
    }

    public FTPClient getClient()
    {
        return ftpClient;
    }

    public void open() throws SocketException, IOException, NException
    {
        final String host = "10.10.1.17";
        final int port = 21;
        final String username = "ipsftp";
        final String password = "!ipsftp1234";

        ftpClient.connect(host, port);

        if (FTPReply.isPositiveCompletion(ftpClient.getReplyCode()) != true) {
            ftpClient.disconnect();
            throw new NSysException("FTP 접속 실패.");
        }

        if (ftpClient.login(username, password) != true) {
            ftpClient.logout();
            throw new NSysException("FTP 로그인 실패.");
        }
    }

    public void close() throws IOException, NException
    {
        if (ftpClient == null) return;
        if (ftpClient.isConnected() != true) return;

        try {
            if (ftpClient.logout() != true) {
                throw new NSysException("FTP 로그아웃 실패.");
            }
        } catch (IOException e) {
            throw e;
        } catch (NSysException e) {
            throw e;
        } finally {
            if (ftpClient != null && ftpClient.isConnected()) {
                ftpClient.disconnect();
            }
        }
    }

    public void put(String localPath, String remoteDir, String remoteFileName) throws NException
    {
        File f = new File(localPath);
        FileInputStream fis = null;

        try {

            ftpClient.changeWorkingDirectory("/");

            String[] paths = remoteDir.split("/");

            for (int i = 0; i < paths.length; i++) {
                if (paths[i].equals("")) continue;
                ftpClient.makeDirectory(paths[i]);
                ftpClient.changeWorkingDirectory(paths[i]);
            }

            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            fis = new FileInputStream(f);

            if (ftpClient.storeFile(remoteFileName, fis) != true) {
                throw new NSysException("파일 [" + localPath + "] 업로드 실패.");
            }

        } catch (Exception e) {
            try {
                this.close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            throw new NException(e);
        } finally {
            if (fis != null) try {
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void get(String remotePath, String localPath) throws NException
    {
        File f = new File(localPath);
        FileOutputStream fos = null;

        f.getParentFile().mkdirs();

        try {

            ftpClient.changeWorkingDirectory("/" + remotePath);

            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            fos = new FileOutputStream(f);
            if (ftpClient.retrieveFile(remotePath, fos) != true) {
                throw new NSysException("파일 [" + remotePath + "] 다운로드 실패.");
            }

        } catch (Exception e) {
            try {
                this.close();
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            throw new NException(e);
        } finally {
            if (fos != null) try {
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
