-- CreateTable
CREATE TABLE "Produit" (
    "id" INTEGER NOT NULL,
    "barecode" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Produit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supermarche" (
    "id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Supermarche_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prix" (
    "idprod" INTEGER NOT NULL,
    "supermarcheid" INTEGER NOT NULL,

    CONSTRAINT "prix_pkey" PRIMARY KEY ("idprod","supermarcheid")
);

-- CreateIndex
CREATE UNIQUE INDEX "Produit_barecode_key" ON "Produit"("barecode");

-- AddForeignKey
ALTER TABLE "prix" ADD CONSTRAINT "prix_idprod_fkey" FOREIGN KEY ("idprod") REFERENCES "Produit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prix" ADD CONSTRAINT "prix_supermarcheid_fkey" FOREIGN KEY ("supermarcheid") REFERENCES "Supermarche"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
