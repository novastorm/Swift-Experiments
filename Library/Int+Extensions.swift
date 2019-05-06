import Foundation

extension Int {
    
    public var factors: [Int] {
        return (2...self).filter{self % $0 == 0}
    }
    
    public var isPrime: Bool {
        if self < 6 {
            return self == 2 || self == 3 || self == 5
        }
        if self & 1 == 0 || self % 3 == 0 {
            return false
        }
        
        let limit = Int(sqrt(Double(self)).rounded(.down))
        
        for t in stride(from: 5, through: limit, by: 6) {
            if self % t == 0 || self % (t+2) == 0 {
                return false
            }
        }
        
        return true
    }
    
    public var primeFactors: [Int:Int] {
        guard self != 0 else {
            return [:]
        }
        
        var n = self
        var results = [Int: Int]()
        var d: Int
        
        if self < 0 {
            n *= -1
        }
        
        d = 2
        while n % d == 0 {
            results[d, default: 0] += 1
            n >>= 1
        }
        
        d = 3
        while n % 3 == 0 {
            results[3, default: 0] += 1
            n /= 3
        }
        
        let limit = Int(sqrt(Double(n)).rounded(.down))
        for d in stride(from: 5, through: limit, by: 6) {
            while n % d == 0 {
                results[d, default: 0] += 1
                n /= d
                
            }
            let dPlus2 = d + 2
            while n % (dPlus2) == 0 {
                results[dPlus2, default: 0] += 1
                n /= dPlus2
            }
        }
        
        if n > 2 {
            results[n] = 1
        }
        
        return results
    }
}
