以下是使用Java提供的对称加解密算法的示例代码：

```java
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class SymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        String plaintext = "Hello, World!";
        String secretKey = "ThisIsASecretKey";

        // 加密
        String encryptedText = encrypt(plaintext, secretKey);
        System.out.println("加密后的文本: " + encryptedText);

        // 解密
        String decryptedText = decrypt(encryptedText, secretKey);
        System.out.println("解密后的文本: " + decryptedText);
    }

    public static String encrypt(String plaintext, String secretKey) throws Exception {
        SecretKeySpec keySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);
        byte[] encryptedBytes = cipher.doFinal(plaintext.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public static String decrypt(String encryptedText, String secretKey) throws Exception {
        SecretKeySpec keySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, keySpec);
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        return new String(decryptedBytes, StandardCharsets.UTF_8);
    }
}
```

上述代码使用AES算法进行对称加解密。请注意，密钥长度对于AES算法是有限制的，常见的密钥长度为128位、192位和256位。在示例中，我们使用了一个简单的字符串作为密钥，但在实际应用中，应该使用更强大和安全的密钥生成方法。