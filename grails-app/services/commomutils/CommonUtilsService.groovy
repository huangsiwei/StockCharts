package commomutils

import grails.transaction.Transactional

import java.security.MessageDigest

@Transactional
class CommonUtilsService {

    def generateRGBA(String rawString, float alpha, float rate) {
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(rawString.getBytes())
        byte[] digest = md.digest()
        StringBuffer sb = new StringBuffer()
        for (byte b : digest) {
            sb.append(String.format("%02x", b & 0xff))
        }
        def r = Math.round(Long.parseLong(sb.substring(0, 2), 16) * rate)
        def g = Math.round(Long.parseLong(sb.substring(2, 4), 16) * rate)
        def b = Math.round(Long.parseLong(sb.substring(4, 6), 16) * rate)
        return "rgba(${r},${g},${b},${alpha})"
    }
}
