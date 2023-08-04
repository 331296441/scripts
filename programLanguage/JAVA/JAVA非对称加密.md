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

# 加密过程
一旦你有了公钥的字符串表示，你可以使用该公钥对数据进行加密。以下是一个示例代码，展示了如何使用公钥字符串进行加密：

```java
import java.security.*;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class AsymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        String plaintext = "Hello, World!";
        String publicKeyString = "YOUR_PUBLIC_KEY_STRING";

        // 将公钥字符串转换为PublicKey对象
        PublicKey publicKey = getPublicKeyFromString(publicKeyString);

        // 加密
        String encryptedText = encrypt(plaintext, publicKey);
        System.out.println("加密后的文本: " + encryptedText);
    }

    public static PublicKey getPublicKeyFromString(String publicKeyString) throws Exception {
        byte[] publicKeyBytes = Base64.getDecoder().decode(publicKeyString);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePublic(keySpec);
    }

    public static String encrypt(String plaintext, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(plaintext.getBytes());
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }
}
```

在上述代码中，你需要将`YOUR_PUBLIC_KEY_STRING`替换为你实际的公钥字符串。然后，使用`getPublicKeyFromString`方法将公钥字符串转换为`PublicKey`对象。最后，使用`encrypt`方法对数据进行加密。加密后的结果将以Base64编码的形式进行打印。

# 解密过程
一旦你有了私钥的字符串表示，你可以使用该私钥对加密的数据进行解密。以下是一个示例代码，展示了如何使用私钥字符串进行解密：

```java
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

public class AsymmetricEncryptionExample {
    public static void main(String[] args) throws Exception {
        String encryptedText = "YOUR_ENCRYPTED_TEXT";
        String privateKeyString = "YOUR_PRIVATE_KEY_STRING";

        // 将私钥字符串转换为PrivateKey对象
        PrivateKey privateKey = getPrivateKeyFromString(privateKeyString);

        // 解密
        String decryptedText = decrypt(encryptedText, privateKey);
        System.out.println("解密后的文本: " + decryptedText);
    }

    public static PrivateKey getPrivateKeyFromString(String privateKeyString) throws Exception {
        byte[] privateKeyBytes = Base64.getDecoder().decode(privateKeyString);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        return keyFactory.generatePrivate(keySpec);
    }

    public static String decrypt(String encryptedText, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        return new String(decryptedBytes);
    }
}
```

在上述代码中，你需要将`YOUR_ENCRYPTED_TEXT`替换为实际的加密文本，将`YOUR_PRIVATE_KEY_STRING`替换为实际的私钥字符串。然后，使用`getPrivateKeyFromString`方法将私钥字符串转换为`PrivateKey`对象。最后，使用`decrypt`方法对加密的数据进行解密。解密后的结果将以字符串形式进行打印。