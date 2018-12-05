package appie;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import com.google.cloud.storage.Acl;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.BucketInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

public class GoogleStorageSample {

	public static void main(String[] args) {
		// Instantiates a client
		Storage storage = StorageOptions.getDefaultInstance().getService();

		// The name for the new bucket
		String bucketName = "istar-user-images"; // "my-new-bucket";

		// Creates the new bucket
		Bucket bucket = storage.create(BucketInfo.of(bucketName));

		System.out.printf("Bucket %s created.%n", bucket.getName());

	}

	public void uploadFile(FileInputStream is, String fileName) {
		Storage storage = StorageOptions.getDefaultInstance().getService();
		String bucketName = "istar-cloud-bucket";
		String folderName = "audio/";
		BlobId blobId = BlobId.of(bucketName, folderName + fileName);
		BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setContentType("application/octet-stream").build();
		Blob blob = storage.create(blobInfo, is);
		Acl acl = storage.createAcl(blobId, Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));
		System.err.println(acl.getId());
		// return blob.getMediaLink();
	}

}
