//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract InvoiceSigner is IERC721Receiver {
    address public voiceContractAddress;

    struct Invoice {
        uint256 invoiceNo;
        uint256 invoiceDate;
        uint256 invoiceTotal;
        uint256 timestamp;
        address signer;
        string cId;
        address userAddress;
        string signedMessage;
    }

    mapping(uint256 => Invoice) invoice;

    uint256 Id = 1;

    address public signerAddress;

    event UpdatedResourceUrl(string oldStr, string newStr);

    constructor(address _signerAddress, address _voiceContractAddress) {
        signerAddress = _signerAddress;
        voiceContractAddress = _voiceContractAddress;
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    function invoiceConfirm(
        uint256 invoiceNo,
        uint256 invoiceDate,
        uint256 invoiceTotal,
        address userAddress,
        string memory cId,
        string memory signedMessage
    ) public {
        VoiceToken obj = VoiceToken(voiceContractAddress);
        require(
            address(msg.sender) == this.signerAddress(),
            "Only the designated signer can call the signer contract"
        );

        uint256 invoiceId = Id++;
        invoice[invoiceId] = Invoice({
            invoiceNo: invoiceNo,
            invoiceDate: invoiceDate,
            invoiceTotal: invoiceTotal,
            timestamp: block.timestamp,
            signer: msg.sender,
            cId: cId,
            userAddress: userAddress,
            signedMessage: signedMessage
        });

        obj.mintNft(cId, userAddress);
    }

    function findInvoiceById(
        uint256 invoiceId
    )
        public
        view
        returns (
            uint256 invoiceNo,
            uint256 invoiceDate,
            uint256 invoiceTotal,
            uint256 timestamp,
            string memory cId,
            address userAddress,
            string memory signedMessage
        )
    {
        Invoice memory obj = invoice[invoiceId];

        return (
            obj.invoiceNo,
            obj.invoiceDate,
            obj.invoiceTotal,
            obj.timestamp,
            obj.cId,
            obj.userAddress,
            obj.signedMessage
        );
    }

    function getSigner() public view returns (address) {
        return signerAddress;
    }

    // function configure(address _voiceContractAddress) external onlyOwner {
    //     require(_voiceContractAddress == address(0), "Contract Already Configured!");
    //     require(_voiceContractAddress != address(0), "Invalid DREX Address");
    //     _drexToken = drexAddress_;
    // }
}

//contract of DREXS token
contract VoiceToken is ERC721, Ownable {
    //Total no. of tokens minted
    uint256 private totalTokensMint;
    uint256 private _totalSupply;
    mapping(uint256 => string) private tokenIdToUri;

    //Initialize the contract with its '_name', '_symbol' and watt contract address
    constructor(
        string memory _name,
        string memory _symbol
    ) Ownable() ERC721(_name, _symbol) {}

    //return total supply
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    //Creates new token from caller's account
    function mintNft(
        string memory ipfsHash,
        address userAddress
    ) external returns (bool) {
        totalTokensMint++;
        tokenIdToUri[totalTokensMint] = ipfsHash;
        _safeMint(userAddress, totalTokensMint);
        _totalSupply++;
        return true;
    }

    //transfer token to another account
    function transfer(address _to, uint256 _tokenId) external {
        safeTransferFrom(msg.sender, _to, _tokenId);
    }

    //return tokenURI of particular token id
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return string(abi.encodePacked(_baseURI(), tokenIdToUri[tokenId]));
    }

    //return the base URI
    function _baseURI() internal view virtual override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    //burn the token
    function burn(uint256 tokenId) external onlyOwner returns (bool) {
        require(
            ownerOf(tokenId) != address(0),
            "ERC721: owner query for nonexistent token"
        );
        _burn(tokenId);
        delete tokenIdToUri[tokenId];
        _totalSupply -= 1;
        return true;
    }
}
