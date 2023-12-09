# List of GenBank files
my @genbank_warm_files = (
    'Acinonyx jubatus.gb', 'Canis lupus.gb', 'Felis catus.gb', 'Megaptera novaeangliae.gb', 'Panthera tigris.gb', 'Spheniscus humboldti.gb', 
    'Ailurus fulgens.gb', 'Carcharodon carcharias.gb', 'Gorilla gorilla gorilla.gb', 'Mirounga angustirostris.gb', 'Panthera uncia.gb', 
    'Tursiops truncatus.gb', 'Aptenodytes forsteri.gb', 'Ceratotherium simum.gb', 'Gorilla gorilla.gb', 'Ornithorhynchus anatinus.gb', 
    'Phascolarctos cinereus.gb', 'Ursus arctos.gb', 'Balaenoptera musculus.gb', 'Chelonia mydas.gb', 'Haliaeetus leucocephalus.gb', 
    'Oryctolagus cuniculus.gb', 'Physeter macrocephalus.gb', 'Ursus maritimus.gb', 'Bison bison.gb', 'Equus caballus.gb', 'Loxodonta africana.gb', 
    'Oryx leucoryx.gb', 'Psittacus erithacus.gb', 'Vulpes vulpes.gb', 'Bos taurus.gb', 'Equus zebra.gb', 'Lynx canadensis.gb', 'Pan paniscus.gb', 
    'Puma concolor.gb', 'Canis lupus familiaris.gb', 'Falco peregrinus.gb', 'Macaca mulatta.gb', 'Pan troglodytes.gb', 'Sarcophilus harrisii.gb'
);

my @genbank_cold_files = (
    'Agkistrodon contortrix.gb', 'Boa constrictor.gb', 'Crotalus adamanteus.gb', 'Hemidactylus frenatus.gb', 'Physignathus cocincinus.gb', 'Sphenodon punctatus.gb',
'Aldabrachelys gigantea.gb', 'Chelydra serpentina.gb', 'Danio rerio.gb', 'Iguana iguana.gb', 'Poecilia reticulata.gb', 'Teratoscincus keyserlingii.gb',
'Alligator mississippiensis.gb', 'Chlamydosaurus kingii.gb', 'Eublepharis macularius.gb', 'Malacochersus tornieri.gb', 'Pogona vitticeps.gb', 'Trachemys scripta elegans.gb',
'Ambystoma laterale.gb', 'Coreius heterodon.gb', 'Gavialis gangeticus.gb', 'Oncorhynchus mykiss.gb', 'Python regius.gb', 'Varanus salvator.gb',
'Ambystoma mexicanum.gb', 'Crocodylus niloticus.gb', 'Geochelone elegans.gb', 'Ophiophagus hannah.gb', 'Salamandra salamandra.gb', 'Xenopus laevis.gb',
'Andrias japonicus.gb', 'Crocodylus rhombifer.gb', 'Heloderma suspectum.gb', 'Phyllobates terribilis.gb', 'Salmo salar.gb'

);




foreach my $genbank_warm_files (@genbank_warm_files) {
    print $genbank_warm_files, "\n";

}