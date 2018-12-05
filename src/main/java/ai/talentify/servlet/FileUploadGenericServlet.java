package ai.talentify.servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.cloud.storage.Acl;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

/**
 * This is a generic file servlet which will based on certail parameters upload
 * the file straight to google storage, upon successful upload it will return a
 * public uri of the file uploaded.
 * 
 * A sample usage can be:
 * 
 * 
 * <form action="upload" method="post" enctype="multipart/form-data">
 * <input type="text" name="description" /> <input type="file" name="file" />
 * <input type="submit" /> </form>
 */
@WebServlet(urlPatterns = "/upload")
@MultipartConfig
public class FileUploadGenericServlet extends HttpServlet {
	private static final Logger logger = LogManager.getLogger(FileUploadGenericServlet.class);

	private static final long serialVersionUID = -1439540307005307177L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		for (Part part : request.getParts()) {
			logger.info(part + "---->" + part.getContentType() + "   " + part.getName());
		}
		Part filePart = request.getPart("file");
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
		FileInputStream is = (FileInputStream) filePart.getInputStream();
		String uploadFile = uploadFile(is, fileName);
		response.getWriter().append("https://storage.googleapis.com/istar-user-images/files/" + fileName);
	}

	private String uploadFile(FileInputStream is, String fileName) {
		Storage storage = StorageOptions.getDefaultInstance().getService();
		String bucketName = "istar-user-images";
		String folderName = "files/";
		BlobId blobId = BlobId.of(bucketName, folderName + fileName);
		BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("image/png").build();
		Blob blob = storage.create(blobInfo, is);
		Acl acl = storage.createAcl(blobId, Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));
		System.err.println(acl.getId());
		return blob.getMediaLink();
	}
}
