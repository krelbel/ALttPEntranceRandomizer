GfxFixer:
{
    lda $b1 : bne .stage2
    jsl Dungeon_InitStarTileCh
    jsl LoadTransAuxGfx
    ;jsl Dungeon_LoadCustomTileAttr
    jsl PrepTransAuxGfx
    lda #$09 : sta $17 : sta $0710
    inc $b1
    rtl
    .stage2
    cmp #$01 : bne .stage3
    lda #$0a : sta $17 : sta $0710
    inc $b1
    rtl
    .stage3
    jsl Palette_SpriteAux3
    jsl Palette_SpriteAux2
    jsl Palette_SpriteAux1
    jsl Palette_DungBgMain
    jsr CgramAuxToMain
    stz $b1 : inc $b0
    rtl
}

CgramAuxToMain: ; ripped this from bank02 because it ended with rts
{
    rep #$20
    ldx.b #$00

    .loop
    lda $7EC300, X : sta $7EC500, x
    lda $7EC340, x : sta $7EC540, x
    lda $7EC380, x : sta $7EC580, x
    lda $7EC3C0, x : sta $7EC5C0, x
    lda $7EC400, x : sta $7EC600, x
    lda $7EC440, x : sta $7EC640, x
    lda $7EC480, x : sta $7EC680, x
    lda $7EC4C0, x : sta $7EC6C0, x

    inx #2 : cpx.b #$40 : bne .loop
    sep #$20

    ; tell NMI to upload new CGRAM data
    inc $15
    rts
}