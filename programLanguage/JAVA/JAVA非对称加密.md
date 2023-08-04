以下是使用Java进行非对称加解密并生成公钥和私钥的示例代码：

```java
import java.security.*;
import java.util.Base64;

public class AsymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        String plaintext = "Hello, World!";

        // 生成公钥和私钥
        KeyPair keyPair = generateKeyPair();
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();

        // 加密
        String encryptedText = encrypt(plaintext, publicKey);
        System.out.println("加密后的文本: " + encryptedText);

        // 解密
        String decryptedText = decrypt(encryptedText, privateKey);
        System.out.println("解密后的文本: " + decryptedText);

        // 打印公钥和私钥
        String publicKeyString = Base64.getEncoder().encodeToString(publicKey.getEncoded());
        String privateKeyString = Base64.getEncoder().encodeToString(privateKey.getEncoded());
        System.out.println("公钥: " + publicKeyString);
        System.out.println("私钥: " + privateKeyString);
    }

    public static KeyPair generateKeyPair() throws Exception {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(2048); // 设置密钥长度为2048位
        return keyPairGenerator.generateKeyPair();
    }

    public static String encrypt(String plaintext, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plaintext.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    public static String decrypt(String encryptedText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        return new String(decryptedBytes);
    }
}
```

上述代码使用RSA算法进行非对称加解密，并生成了公钥和私钥。请注意，密钥长度对于RSA算法也是有限制的，常见的密钥长度为1024位、2048位和4096位。在示例中，我们使用了2048位的密钥长度。生成的公钥和私钥以Base64编码的形式进行打印。在实际应用中，应该妥善保管私钥，并使用公钥进行加密，私钥进行解密。